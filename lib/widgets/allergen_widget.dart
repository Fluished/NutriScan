import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AllergenWidget extends StatefulWidget {
  final List<String> initialAllergens;
  final Function(List<String>) onAllergensSelected;

  const AllergenWidget({
    super.key,
    this.initialAllergens = const [], // Optional, defaults to empty list
    required this.onAllergensSelected,
  });

  @override
  State<AllergenWidget> createState() => _AllergenWidgetState();
}

class _AllergenWidgetState extends State<AllergenWidget> {
  final List<String> commonAllergens = [
    'peanuts',
    'milk',
    'eggs',
    'soy',
    'wheat',
    'fish',
    'shellfish',
    'tree nuts',
  ];
  late List<String> selectedAllergens;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize with initialAllergens (defaults to [] if not provided)
    selectedAllergens = List.from(widget.initialAllergens);
  }

  Future<void> _handleSaveAllergens(bool skip) async {
    setState(() => _isLoading = true);
    try {
      List<String> allergensToSave;
      if (skip) {
        // Skip clears allergens
        allergensToSave = [];
      } else {
        // Done: Save selected allergens, or keep initialAllergens if none selected
        allergensToSave = selectedAllergens.isEmpty ? widget.initialAllergens : selectedAllergens;
      }
      // Call callback with allergens to save
      widget.onAllergensSelected(allergensToSave);
      // Close dialog
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving allergens: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Colors.white,
        unselectedWidgetColor: Colors.black, // For checkbox border when unchecked
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.black; // Checkmark color
            }
            return Colors.white; // Default fill
          }),
          checkColor: MaterialStateProperty.all(Colors.white), // Color of the check inside box
          side: const BorderSide(color: Colors.black), // Border when not selected
        ),
      ),
      child: AlertDialog(
        title: const Text("Select Your Allergens"),
        content: SingleChildScrollView(
          child: Column(
            children: commonAllergens.map((allergen) {
              return CheckboxListTile(
                title: Text(allergen, style: const TextStyle(color: Colors.black)),
                value: selectedAllergens.contains(allergen),
                onChanged: _isLoading
                    ? null
                    : (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedAllergens.add(allergen);
                    } else {
                      selectedAllergens.remove(allergen);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : () => _handleSaveAllergens(false),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text("Done"),
          ),
        ],
      ),
    );
  }
}