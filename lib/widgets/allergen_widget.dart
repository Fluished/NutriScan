import 'package:flutter/material.dart';

class AllergenWidget extends StatefulWidget {
  final VoidCallback onDone;

  const AllergenWidget({super.key, required this.onDone});

  @override
  State<AllergenWidget> createState() => _AllergenDialogState();
}

class _AllergenDialogState extends State<AllergenWidget> {
  List<String> allergens = [
    'celery', 'crustaceans', 'fish', 'sesame', 'milk', 'soybeans',
    'eggs', 'gluten', 'mollusks', 'sulphur dioxide', 'lupin', 'peanuts',
    'sulphites', 'mustard', 'tree nuts'
  ];

  Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Center(
        child: Text(
          'Allergen Set Up',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allergens.map((item) {
                final isSelected = selected.contains(item);
                return ChoiceChip(
                  label: Text(item),
                  selected: isSelected,
                  selectedColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(color: Colors.black),
                  ),
                  onSelected: (val) {
                    setState(() {
                      if (isSelected) {
                        selected.remove(item);
                      } else {
                        selected.add(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    widget.onDone(); // Navigate to next screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text("Skip", style: TextStyle(color: Colors.white)),
                  ),
                ),

                const SizedBox(width: 16),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    widget.onDone(); // Navigate to next screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text("Done", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
