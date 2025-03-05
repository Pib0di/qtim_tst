import 'package:qtim_tst/data/database/app_database.dart';

class CartRepository {
  final AppDatabase database;

  CartRepository(this.database);

  Future<void> addToCart(CartItem item) async {
    final existingItem = await (database.select(database.cartItems)
          ..where((tbl) => tbl.productId.equals(item.productId)))
        .getSingleOrNull();

    if (existingItem != null) {
      final updatedItem = CartItem(
        id: existingItem.id,
        productId: item.productId,
        product: item.product,
        quantity: existingItem.quantity + 1,
        variant: item.variant,
      );
      await database.into(database.cartItems).insertOnConflictUpdate(updatedItem);
    } else {
      await database.into(database.cartItems).insertOnConflictUpdate(item);
    }
  }

  Future<void> clearCart() async {
    await database.delete(database.cartItems).go();
  }

  Future<List<CartItem>> getCartItems() async => await database.select(database.cartItems).get();

  Future<void> add(String id) async {
    final item = await (database.select(database.cartItems)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (item != null) {
      final updatedItem = CartItem(
        id: item.id,
        productId: item.productId,
        product: item.product,
        quantity: item.quantity + 1,
        variant: item.variant,
      );
      await database.into(database.cartItems).insertOnConflictUpdate(updatedItem);
    }
  }

  Future<void> subtract(String id) async {
    final item = await (database.select(database.cartItems)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (item != null && item.quantity > 1) {
      final updatedItem = CartItem(
        id: item.id,
        productId: item.productId,
        product: item.product,
        quantity: item.quantity - 1,
        variant: item.variant,
      );
      await database.into(database.cartItems).insertOnConflictUpdate(updatedItem);
    } else if (item != null && item.quantity == 1) {
      await deleteById(id);
    }
  }

  Future<void> deleteById(String id) async {
    await (database.delete(database.cartItems)..where((tbl) => tbl.id.equals(id))).go();
  }
}
