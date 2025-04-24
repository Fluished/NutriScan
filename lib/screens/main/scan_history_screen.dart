import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by barcode or product',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),

        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: const [
              Expanded(flex: 2, child: Text("Barcode #", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text("Product", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text("Price", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),

        const SizedBox(height: 6),

        // List
        Expanded(
          child: ListView.builder(
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            product['barcode'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                      ),
                      Expanded(flex: 2, child: Text(product['date'])),
                      Expanded(flex: 2, child: Text(product['product'])),
                      Expanded(flex: 1, child: Text(product['price'])),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product['isSafe'] ? "Safe" : "Not Safe",
                              style: TextStyle(
                                color: product['isSafe'] ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
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
    );
  }
}
