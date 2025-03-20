import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart'; // Import GetX

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController(); // Optional name field
  String? _errorMessage;
  bool _isLoading = false;

  // *** IMPORTANT: Make sure this matches your LoginPage PocketBase instance ***
  final pb = PocketBase('https://first.pockethost.io/');

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _passwordConfirmController.text) {
        setState(() {
          _errorMessage = "Passwords do not match.";
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final body = <String, dynamic>{
          "email": _emailController.text.trim().toLowerCase(), // Ensure email is lowercase
          "password": _passwordController.text,
          "passwordConfirm": _passwordConfirmController.text,
          "emailVisibility": true, // Or false, depending on your needs
          "name": _nameController.text.trim(), // Optional name
          // You can add other fields here if your 'users' collection has them
        };

        final record = await pb.collection('users').create(body: body);
        print('Registration successful! User ID: ${record.id}');

        // Optional: Send email verification request (after successful registration)
        try {
          await pb.collection('users').requestVerification(_emailController.text.trim().toLowerCase()); // Ensure email is lowercase for verification too
          print('Verification email sent to ${_emailController.text.trim()}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification email sent!')),
          );
        } catch (verificationError) {
          print('Error sending verification email: $verificationError');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful, but error sending verification email.')),
          );
        }

        // Navigate back to login page after successful registration using GetX
        Get.back(); // Go back to the previous page (LoginPage) using GetX

      } catch (e) {
        print('Registration Error: $e');
        setState(() {
          _errorMessage = 'Registration failed. Please check your details and try again.';
          // You can add more specific error handling based on 'e' if needed
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the maximum width
    final double maxWidth = 400.0; // Adjust this value as needed

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView( // Make form scrollable if content is too long
              child: ConstrainedBox( // Constrain the column's width
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ConstrainedBox( // Wrap TextFormField
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox( // Wrap TextFormField
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: TextFormField(
                        controller: _nameController, // Optional Name field
                        decoration: const InputDecoration(
                          labelText: 'Name (Optional)',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox( // Wrap TextFormField
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 8) { // Example password length validation
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox( // Wrap TextFormField
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: TextFormField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    ConstrainedBox( // Wrap ElevatedButton
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Register'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox( // Wrap TextButton
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: TextButton(
                        onPressed: () {
                          Get.back(); // Go back to Login Page using GetX
                        },
                        child: const Text('Already have an account? Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}