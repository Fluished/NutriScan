import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Logo and Title
              Row(
                children: const [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
                    child: Text("LOGO", style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Log In",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Illustration Image
              Image.asset(
                'assets/login_asset.png',
                height: mediaQuery.height * 0.22,
              ),
              const SizedBox(height: 10),


              _buildTextField(icon: Icons.email, hint: "Email or Phone number"),
              const SizedBox(height: 10),

              _buildPasswordField(
                hint: "Password",
                isVisible: _isPasswordVisible,
                onToggle: () => setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                }),
              ),
              const SizedBox(height: 10),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Submit logic
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Sign In", style: TextStyle(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 10),
              const Text("or sign in with"),
              const SizedBox(height: 10),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(FontAwesomeIcons.facebookF),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.envelope),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.twitter),
                ],
              ),

              const Spacer(),

              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Don't have an account? "),
                  Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hint,
  }) {
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

  Widget _buildPasswordField({
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return TextField(
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }
}