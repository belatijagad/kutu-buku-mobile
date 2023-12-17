// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kutubuku/utils/constants.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Form(
        // padding: const EdgeInsets.all(16.0),
        key: _formKey,
        child: SizedBox(
          // width: size.width,
          // height: size.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              // width: size.width * 0.85,
              margin: const EdgeInsets.all(50),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Welcome!", // Teks baru ditambahkan di sini
                        style: TextStyle(
                          fontSize: 30, // Atur ukuran font sesuai kebutuhan
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                        hintText: "Masukkan username",
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white)),
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
                        hintText: "Masukkan kata sandi",
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white)),
                        suffixIcon: IconButton(
                          icon: Icon(!_passwordVisible
                              ? Icons.visibility
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
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: !_confirmPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi katasandi invalid';
                        }
                        if (value != _passwordController.text) {
                          return 'Konfirmasi katasandi tidak cocok';
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        labelText: 'Konfirmasi kata sandi',
                        hintText: "Masukkan kembali kata sandi",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(!_confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        // Perform registration logic
                        if (_fieldsIsNotEmpty()) {
                          _performRegistration(context, request);
                        } else {
                          _showErrorDialog(
                              'Username atau kata sandi tidak valid. Coba lagi.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 12.0),
                    TextButton(
                      onPressed: () {
                        // Navigate to the registration page
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Kembali ke Login',
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
    );
  }

  bool _fieldsIsNotEmpty() {
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _performRegistration(BuildContext context, request) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Konfirmasi kata sandi tidak cocok');
    } else {
      String username = _usernameController.text;
      String password = _passwordController.text;
      try {
        final response = await http.post(
          Uri.parse(Constants.register),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'username': username,
            'password': password,
          },
        );

        if (response.statusCode == 201) {
          // Handle successful registration
          Navigator.pop(context);
        } else {
          // Handle error
          print('Registration failed: ${response.body}');
          _showErrorDialog('Username dengan nama ini sudah ada!');
        }
      } catch (e) {
        // Handle network error or other exceptions
        print('Registration error: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gagal Mendaftar'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
