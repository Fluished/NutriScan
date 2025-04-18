import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Top Back Button + Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  const Text(
                    "Complete Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 10),

              // Illustration Image
              Image.asset(
                'assets/auth/complete_profile_asset.png',
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              const SizedBox(height: 10),

              // Input Fields
              _buildTextField(hint: "First Name", icon: Icons.person),
              const SizedBox(height: 12),
              _buildTextField(hint: "Middle Name", icon: Icons.person_outline),
              const SizedBox(height: 12),
              _buildTextField(hint: "Last Name", icon: Icons.person),
              const SizedBox(height: 12),
              _buildTextField(hint: "Phone number", icon: Icons.phone),
              const SizedBox(height: 12),
              _buildTextField(hint: "Bio", icon: Icons.person_2_outlined),
              const SizedBox(height: 20),

              // Proceed Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AllergenWidget(
                        onDone: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => ScreenHandler()), //TODO
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Proceed",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }
}
