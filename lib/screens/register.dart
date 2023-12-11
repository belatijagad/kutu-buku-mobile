import 'package:flutter/material.dart';

class ReaderRegistrationPage extends StatefulWidget {
  const ReaderRegistrationPage({super.key});

  @override
  _ReaderRegistrationPageState createState() => _ReaderRegistrationPageState();
}

class _ReaderRegistrationPageState extends State<ReaderRegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/kutubuku1.png",
          width: 140,
          height: 90,
          ),
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
                margin: EdgeInsets.all(50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
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
                          hintText: "Masukkan username",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
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
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(!_passwordVisible ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState( () {
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
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(!_confirmPasswordVisible ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState( () {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                },
                              );
                            },
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
                            _showErrorDialog('Username atau kata sandi tidak valid. Coba lagi.');
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
          )
        ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.tealAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                // navigate to home page
              },
            ),
            ),
            Expanded(
              child: Text(
                'Copyright © PBP B10 2023',
                style: TextStyle(fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                // navigate to about page
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _fieldsIsNotEmpty() {
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _performRegistration(BuildContext context) {
    if (_passwordController.text != _confirmPasswordController.text) {
        _showErrorDialog('Konfirmasi kata sandi tidak cocok');
    } else {
      // Logic pendaftaran
      // print('Registration logic here');
      Navigator.pop(context);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Gagal Mendaftar'),
        content: Text(message),
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
