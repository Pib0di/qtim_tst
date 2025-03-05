// /features/catalog/presentation/product_detail_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  static const String routeName = '/product-detail';

  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  static const List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'Смартфон',
      'imageUrl':
          'https://avatars.mds.yandex.net/get-mpic/4410238/img_id8371345192538900985.jpeg/orig',
      'description': 'Мощный смартфон с отличной камерой',
      'price': 599.99,
    },
    {
      'id': '2',
      'name': 'Ноутбук',
      'imageUrl':
          'https://a.allegroimg.com/original/1165bc/55b564cd45919a2bfbf89f7c91d2/Lenovo-ThinkPad-L560-I5-6gen-8-256GB-SSD-HD-WIN-10-Office-Marka-IBM-Lenovo',
      'description': 'Производительный ноутбук для работы и игр',
      'price': 1299.99,
    },
    {
      'id': '3',
      'name': 'Футболка',
      'imageUrl': 'https://cdn1.ozone.ru/s3/multimedia-g/6556208332.jpg',
      'description': 'Удобная хлопковая футболка',
      'price': 19.99,
    },
  ];

  @override
  Widget build(BuildContext context, ref) {
    final product = products.firstWhere((p) => p['id'] == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product['imageUrl'],
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['description'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${product['price']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product['id'], jsonEncode(product));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product['name']} добавлен в корзину')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Добавить в корзину'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
