// core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtim_tst/features/cart/presentation/cart_page.dart';
import 'package:qtim_tst/features/catalog/presentation/product_detail_screen.dart';
import 'package:qtim_tst/features/catalog/presentation/product_screen.dart';
import 'package:qtim_tst/features/profile/presentation/profile.dart';

import '../../features/catalog/catalog.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root_page');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorCatalogKey = GlobalKey<NavigatorState>(debugLabel: 'speech');
final _shellNavigatorCartKey = GlobalKey<NavigatorState>(debugLabel: 'yogaVideos');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: ProfileScreen.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        //
        //Profile page
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              name: '$ProfileScreen',
              path: ProfileScreen.routeName,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),

        //
        // Catalog Page
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCatalogKey,
          routes: [
            GoRoute(
              name: '$CatalogScreen',
              path: CatalogScreen.routeName,
              builder: (context, state) => const CatalogScreen(),
              routes: [
                GoRoute(
                  name: '$ProductListScreen',
                  path: '${ProductListScreen.routeName}/:categoryId',
                  builder: (context, state) {
                    final categoryId = state.pathParameters['categoryId']!;
                    return ProductListScreen(categoryId: categoryId);
                  },
                ),
                GoRoute(
                  name: '$ProductDetailScreen',
                  path: '${ProductDetailScreen.routeName}/:productId',
                  builder: (context, state) {
                    final categoryId = state.pathParameters['productId']!;
                    return ProductDetailScreen(productId: categoryId);
                  },
                ),
              ],
            ),
          ],
        ),

        //
        //Home Page
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCartKey,
          routes: [
            GoRoute(
              name: '$CartScreen',
              path: CartScreen.routeName,
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNestedNavigation> createState() => _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState extends State<ScaffoldWithNestedNavigation> {
  int index = 0;
  void _goBranch(int index) {
    this.index = index;
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.white,
        // indicatorColor: Colors.grey.shade300,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _goBranch,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blueGrey[200]),
            activeIcon: Icon(Icons.person, color: Colors.blueGrey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: Colors.blueGrey[200]),
            activeIcon: Icon(Icons.category, color: Colors.blueGrey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.blueGrey[200]),
            activeIcon: Icon(Icons.add, color: Colors.blueGrey),
            label: '',
          ),
        ],
      ),
    );
  }
}
