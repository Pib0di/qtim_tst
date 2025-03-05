// /features/catalog/presentation/product_list_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_tst/core/router/router_extensions.dart';
import 'package:qtim_tst/data/providers/cart_provider.dart';
import 'package:qtim_tst/features/catalog/presentation/product_detail_screen.dart';

import '../../../core/router/router.dart';

class ProductListScreen extends ConsumerWidget {
  static const String routeName = '/product';

  final String categoryId;

  const ProductListScreen({super.key, required this.categoryId});

  // Захардкоженные данные товаров
  static const List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'categoryId': '1',
      'name': 'Смартфон',
      'imageUrl':
          'https://avatars.mds.yandex.net/get-mpic/4410238/img_id8371345192538900985.jpeg/orig',
      'price': 599.99,
    },
    {
      'id': '2',
      'categoryId': '1',
      'name': 'Ноутбук',
      'imageUrl':
          'https://a.allegroimg.com/original/1165bc/55b564cd45919a2bfbf89f7c91d2/Lenovo-ThinkPad-L560-I5-6gen-8-256GB-SSD-HD-WIN-10-Office-Marka-IBM-Lenovo',
      'price': 1299.99,
    },
    {
      'id': '3',
      'categoryId': '2',
      'name': 'Футболка',
      'imageUrl': 'https://cdn1.ozone.ru/s3/multimedia-g/6556208332.jpg',
      'price': 19.99,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Фильтруем товары по categoryId
    final categoryProducts =
        products.where((product) => product['categoryId'] == categoryId).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Товары'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];
          return Card(
            child: ListTile(
              leading: Image.network(
                product['imageUrl'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product['name']),
              subtitle: Text('\$${product['price']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  ref
                      .read(cartProvider.notifier)
                      .addToCart(product['id'], jsonEncode(product))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product['name']} добавлен в корзину')),
                    );
                  });
                },
                child: const Text('В корзину'),
              ),
              onTap: () => onTap(product['id']),
            ),
          );
        },
      ),
    );
  }

  void onTap(String id) {
    router.pushClassNamed(ProductDetailScreen, pathParameters: {'productId': id});
  }
}
