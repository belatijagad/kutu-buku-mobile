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
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.tealAccent,
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          child: Align (
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(50),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(10)
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        labelText: 'Username',
                        hintText: 'Masukkan username',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white, width: 0.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password invalid';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        labelText: 'Kata sandi',
                        hintText: 'Masukkan kata sandi',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(!_passwordVisible ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                _passwordVisible = !_passwordVisible;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        // Perform login logic (authentication check)
                        if (_performLogin()) {
                          // If successful, navigate to the home page
                          Navigator.pushReplacement(
                            context,
                            // DUMMY ROUTING: navigate ke LoginPage (harusnya ke HomePage())
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
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // navigate to home page
              },
            ),
            Text(
              'Copyright © PBP B10 2023',
              style: TextStyle(fontSize: 14.0),
            ),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                // navigate to about page
              },
            ),
          ],
        ),
        height: 50.0,
        color: Colors.tealAccent,
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
        title: Text('Gagal masuk'),
        content: Text('Username atau kata sandi tidak valid.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }
}