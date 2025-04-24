import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Picture and Edit Button
          Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "First S. Last",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "A Health Enthusiast",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              // Edit Button ==============
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   child: ElevatedButton.icon(
              //     onPressed: () {},
              //     icon: const Icon(Icons.edit, size: 16),
              //     label: const Text("Edit"),
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //       backgroundColor: Colors.white,
              //       foregroundColor: Colors.black,
              //       side: const BorderSide(color: Colors.black12),
              //       shape: StadiumBorder(),
              //     ),
              //   ),
              // ),
            ],
          ),
          const Divider(height: 32, thickness: 1.2),

          // Personal Info
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Personal Information", style: Theme.of(context).textTheme.titleMedium),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(child: _buildInputBox("First Name", "First")),
              const SizedBox(width: 8),
              Expanded(child: _buildInputBox("Last Name", "Last")),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildInputBox("Email Address", "test.email@email.test")),
              const SizedBox(width: 8),
              Expanded(child: _buildInputBox("Phone No.", "09121234321")),
            ],
          ),

          const SizedBox(height: 24),

          // Allergen Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Allergen Profile", style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
                  ],
                ),
                const Text("User Allergens", style: TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(3, (_) => _buildPill()),
                ),
                const SizedBox(height: 16),
                const Text("Suggested Allergens", style: TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(6, (_) => _buildPill()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),

        const SizedBox(height: 4),

        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildPill() {
    return Container(
      width: 80,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
