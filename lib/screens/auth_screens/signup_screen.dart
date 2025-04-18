import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
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
                "Create your Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 20),

              Image.asset(
                'assets/auth/login_asset.png',
                height: ScreenUtils.imageHeightHalf(context),
              ),
              const SizedBox(height: 10),

              // Form Fields
              _buildTextField(icon: Icons.person, hint: "Name"),
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

              _buildPasswordField(
                hint: "Confirm Password",
                isVisible: _isConfirmPasswordVisible,
                onToggle: () => setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                }),
              ),
              const SizedBox(height: 12),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => AppNavigator.push(context, CompleteProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 10),
              const Text("or sign up with"),
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
                  Text("Already have an account? "),
                  Text(
                    "Log In",
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