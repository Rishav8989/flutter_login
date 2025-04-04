import 'package:flutter/material.dart';
import 'package:login/registration_page.dart';
import 'pages/home_page.dart'; // Import HomePage
import 'main.dart'; // Import the global pb instance
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:get/get.dart'; // Import GetX

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'temp@mail.com'); // Default email
  final _passwordController = TextEditingController(text: 'Temp@mail'); // Default password
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pb_auth_token', token);
    print('Token stored in cache');
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null; // Clear previous errors
      });

      try {
        final authData = await pb.collection('users').authWithPassword(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );

        // Login successful!
        print('Login successful!');
        print('Auth Store Valid: ${pb.authStore.isValid}');
        print('Auth Token: ${pb.authStore.token}');
        print(
            'User ID: ${pb.authStore.record?.id}'); // Use ?. to avoid null access error if record is null

        // Store the token in cache
        await _storeToken(pb.authStore.token);

        // Navigate to the home page using GetX
        Get.offAll(() => const HomePage());

      } catch (e) {
        // Catch ANY error for now - simplified error handling
        print(
            'Login Error: $e'); // Print the full error to console for debugging
        setState(() {
          _errorMessage =
              'Login failed. Please check your credentials and try again.'; // Basic error message
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the maximum width
    final double maxWidth = 400.0; // Adjust this value as needed

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              // ADDED: Constrain the column's width
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
                  ConstrainedBox(
                    // Added to wrap TextFormField
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email or Username',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Rounded border
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next, // Moves focus to next field on Enter
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    // Added to wrap TextFormField
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Rounded border
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done, // Hides keyboard on Enter
                      onFieldSubmitted: (value) {
                        if (_emailController.text.isNotEmpty) {
                          _login();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  ConstrainedBox(
                    // Added to wrap ElevatedButton
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Rounded border
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    // Added to wrap TextButton
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: TextButton(
                      onPressed: () {
                        // Navigate to registration page using GetX
                        Get.to(() => const RegistrationPage());
                      },
                      child: const Text('Don\'t have an account? Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}