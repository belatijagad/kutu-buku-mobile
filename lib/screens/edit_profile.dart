// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kutubuku/utils/constants.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _username = "";

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    Future<dynamic> getUser() async {
      final response = await request.get(Constants.getUser);
      return response;
    }

    getUser().then((value) => {
          if (mounted) setState(() {
            _username = value['username'];
          })
        });

    void performPasswordChange(BuildContext context, request) async {
      if (_oldPassword.text == _newPassword.text) {
        _showErrorDialog('Kata sandi baru tidak boleh sama dengan yang lama!');
      } else {
        String oldpassword = _oldPassword.text;
        String newpassword = _newPassword.text;
        try {
          final response = await request.post(Constants.changePassword, {
            'old_password': oldpassword,
            'new_password': newpassword,
          });

          if (response['status'] == true) {
            Navigator.pop(context);
            request.login(Constants.login, {
              'username': _username,
              'password': newpassword,
            });
          } else {
            // Handle error
            _showErrorDialog('Username dengan nama ini sudah ada!');
          }
        } catch (e) {
          // Handle network error or other exceptions
          print('Edit error: $e');
        }
      }
    }

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
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password invalid';
                        }
                        return null;
                      },
                      controller: _oldPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        labelText: 'Kata sandi lama',
                        hintText: "Masukkan kata sandi lama Anda",
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
                        return null;
                      },
                      controller: _newPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal.shade50,
                        labelText: 'Kata sandi baru',
                        hintText: "Masukkan kata sandi baru Anda",
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
                          performPasswordChange(context, request);
                        } else {
                          _showErrorDialog(
                              'Username atau kata sandi tidak valid. Coba lagi.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Change Password'),
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
    return _oldPassword.text.isNotEmpty && _newPassword.text.isNotEmpty;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gagal Mengganti Kata Sandi'),
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
