import 'package:flutter/material.dart';
import 'package:qtim_tst/core/router/router.dart';
import 'package:qtim_tst/core/router/router_extensions.dart';
import 'package:qtim_tst/features/catalog/presentation/product_screen.dart';

class CatalogScreen extends StatefulWidget {
  static const String routeName = '/catalog';

  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  static const List<Map<String, dynamic>> categories = [
    {
      'id': '1',
      'name': 'Электроника',
      'imageUrl': 'https://gaap.ru/upload/blog/avatar/024/fignya.png',
      'productCount': 2,
    },
    {
      'id': '2',
      'name': 'Одежда',
      'imageUrl':
          'https://thumbs.dreamstime.com/b/businesswoman-clothes-set-high-heel-shoes-bag-dress-isolated-vector-illustration-47980342.jpg',
      'productCount': 1,
    },
    {
      'id': '3',
      'name': 'Книги',
      'imageUrl': 'https://i.pinimg.com/736x/1c/07/33/1c07332fb67285b05a7dbc7627ac703f.jpg',
      'productCount': 0,
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories.where((category) {
      final name = category['name'].toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог'),
      ),
      body: Column(
        children: [
          // Поле поиска
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Поиск категорий...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Список категорий
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return GestureDetector(
                  onTap: () => onTap(category['id']),
                  child: Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            category['imageUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Товаров: ${category['productCount']}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onTap(String id) {
    router.goClassNamed(ProductListScreen, pathParameters: {'categoryId': id});
  }
}
