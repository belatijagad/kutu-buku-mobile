import 'package:flutter/material.dart';
import 'package:kutubuku/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Back!'),
        backgroundColor: Colors.tealAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Perform login logic (authentication check)
                if (_performLogin()) {
                  // If successful, navigate to the home page
                  Navigator.pushReplacement(
                    context,
// DUMMY ROUTING: navigate ke LoginPage
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  // Show an error message or handle authentication failure
                  _showErrorDialog();
                }
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12.0),
            TextButton(
              onPressed: () {
                // Navigate to the registration page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReaderRegistrationPage()),
                );
              },
              child: const Text('Belum punya akun?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _performLogin() {
    // Replace this with your actual authentication logic
    // For simplicity, we'll just check if both fields are non-empty
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
        content: Text('Invalid username or password. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}