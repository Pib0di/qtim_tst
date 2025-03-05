import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_tst/data/database/app_database.dart';
import 'package:qtim_tst/features/cart/data/cart_repo.dart';

import 'database_provider.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository(ref.watch(databaseProvider));
});

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier(ref.watch(cartRepositoryProvider));
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  final CartRepository repository;

  CartNotifier(this.repository) : super([]) {
    _loadCart();
  }

  Future<void> clearCart() async {
    await repository.clearCart();
    state = await repository.getCartItems();
  }

  Future<void> _loadCart() async {
    state = await repository.getCartItems();
  }

  Future<void> addToCart(String productId, String product, {String? variant}) async {
    final item = CartItem(
      id: productId,
      productId: productId,
      product: product,
      quantity: 1,
      variant: variant,
    );
    await repository.addToCart(item);
    state = await repository.getCartItems();
  }

  Future<void> deleteById(String id) async {
    await repository.deleteById(id);
    state = await repository.getCartItems();
  }

  Future<void> add(String id) async {
    await repository.add(id);
    state = await repository.getCartItems();
  }

  Future<void> subtract(String id) async {
    await repository.subtract(id);
    state = await repository.getCartItems();
  }
}
