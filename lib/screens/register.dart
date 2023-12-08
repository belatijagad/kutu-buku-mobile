import 'package:flutter/material.dart';

class ReaderRegistrationPage extends StatefulWidget {
  const ReaderRegistrationPage({super.key});

  @override
  _ReaderRegistrationPageState createState() => _ReaderRegistrationPageState();
}

class _ReaderRegistrationPageState extends State<ReaderRegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome!'),
          backgroundColor: Colors.tealAccent,
        ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            "Register",
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
                            labelText: 'Username',
                            hintText: "Masukkan username",
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password invalid';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Kata sandi',
                            hintText: "Masukkan kata sandi",
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi katasandi invalid';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Konfirmasi kata sandi',
                            hintText: "Masukkan kembali kata sandi",
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // TextField(
                        //   controller: _passwordController,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //       labelText: 'Confirm your Password'),
                        // ),

                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () {
                            // Perform registration logic
                            if (_fieldsIsNotEmpty()) {
                              _performRegistration(context);
                            } else {
                              _showErrorDialog();
                            }
                          },
                          child: const Text('Register'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
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
            )));
  }

  bool _fieldsIsNotEmpty() {
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _performRegistration(BuildContext context) {
    // Replace this with your actual registration logic
    // For simplicity, we'll just print a message
    // print('Registration logic here');
    Navigator.pop(context);
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Gagal Mendaftar'),
        content: Text('Username atau kata sandi tidak valid. Coba lagi.'),
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
