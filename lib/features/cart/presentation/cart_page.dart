import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_tst/core/router/router.dart';
import 'package:qtim_tst/core/router/router_extensions.dart';
import 'package:qtim_tst/data/database/app_database.dart';
import 'package:qtim_tst/data/providers/cart_provider.dart';
import 'package:qtim_tst/features/catalog/presentation/product_detail_screen.dart';

class CartScreen extends ConsumerWidget {
  static const String routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartList = ref.watch(cartProvider);
    final provider = ref.watch(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Всего: ${getAllCount(cartList)}'),
              ElevatedButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).clearCart();
                },
                child: Text('Clear'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final product = jsonDecode(cartList[index].product);
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      product['imageUrl'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Icon(Icons.error, size: 50);
                      },
                    ),
                    title: Text(product['name']),
                    subtitle: Text('\$${product['price']} : ${cartList[index].quantity} шт'),
                    trailing: SizedBox(
                      width: 100,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              top: -20,
                              right: 0,
                              child: IconButton(
                                  onPressed: () => provider.deleteById(cartList[index].id),
                                  icon: Icon(Icons.delete))),
                          Positioned(
                            bottom: -10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () => provider.subtract(cartList[index].id),
                                    icon: Icon(Icons.exposure_minus_1)),
                                IconButton(
                                    onPressed: () => provider.add(cartList[index].id),
                                    icon: Icon(Icons.plus_one))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => onTap(product['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int getAllCount(List<CartItem> cartList) {
    var count = cartList.map((product) {
      return product.quantity;
    }).fold(0, (count, quantity) {
      return count += quantity;
    });
    return count;
  }

  void onTap(String id) {
    router.pushClassNamed(ProductDetailScreen, pathParameters: {'productId': id});
  }
}
