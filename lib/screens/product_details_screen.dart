import 'package:flutter/material.dart';
import 'package:nutriscan/utils/utils.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String barcode;
  const ProductDetailsScreen({super.key, required this.barcode});

  final bool isFavorite = false;
  final bool isSafe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.clipper,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Product Image + Star
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/todo.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {}, // handle toggle
                  ),
                ],
              ),

              const SizedBox(height: 8),
              const Text("Peanuts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Image.asset('assets/todo.png', width: 120),
              const SizedBox(height: 4),
              Text(barcode, style: TextStyle(color: Colors.blue)),

              const SizedBox(height: 24),

              // Nutritional Info Grid
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _infoCard("Calories", "567 calories", Icons.local_fire_department),
                  _infoCard("Nutrients", "Protein, Fats, Carbs, etc.", Icons.restaurant),
                  _infoCard("Ingredients", "Peanuts, Salt, Oil, Sugar & Flavorings", Icons.list),
                  _infoCard("Nutritional Info", "Fat: 49.2g, Fiber: 8.5g, Sugars: 4.7g...", Icons.info),
                ],
              ),

              const SizedBox(height: 20),

              // Healthy Alternatives
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Healthy alternatives you can try", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _altCard("Chia Seeds", "Lorem ipsum amet dolor, ettu tu"),
                    _altCard("Apple", "Lorem ipsum amet dolor, ettu tu"),
                    _altCard("Avocados", "Lorem ipsum amet dolor, ettu tu"),
                    _altCard("Brown Rice", "Lorem ipsum amet dolor, ettu tu"),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String content, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 16),
            const SizedBox(width: 6),
            Flexible(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          ]),
          const SizedBox(height: 8),
          Text(
            content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _altCard(String title, String subtitle) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/todo.png', // placeholder image
              height: 60,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
