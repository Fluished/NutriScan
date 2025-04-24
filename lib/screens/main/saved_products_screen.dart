import 'package:flutter/material.dart';

class SavedProductsScreen extends StatefulWidget {
  const SavedProductsScreen({super.key});

  @override
  State<SavedProductsScreen> createState() => _SavedProductsScreenState();
}

class _SavedProductsScreenState extends State<SavedProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allProducts = [
    {'barcode': '123-456-789', 'date': 'Dec 9', 'product': 'Nuts', 'price': 'P100', 'isSafe': true, 'isFavorite': true},
    {'barcode': '987-654-321', 'date': 'Dec 8', 'product': 'Chocolate', 'price': 'P50', 'isSafe': true, 'isFavorite': false},
    {'barcode': '321-654-987', 'date': 'Dec 7', 'product': 'Milk', 'price': 'P70', 'isSafe': false, 'isFavorite': true},
  ];

  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_allProducts);
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product['barcode'].toLowerCase().contains(query) ||
            product['product'].toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      _filteredProducts[index]['isFavorite'] = !_filteredProducts[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Field
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by barcode or product',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),

        // Product List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 6),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(product['barcode']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date: ${product['date']}"),
                      Text("Product: ${product['product']}"),
                      Text("Price: ${product['price']}"),
                      Text(
                        product['isSafe'] ? "Safe" : "Not Safe",
                        style: TextStyle(color: product['isSafe'] ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      product['isFavorite'] ? Icons.star : Icons.star_border,
                      color: product['isFavorite'] ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}