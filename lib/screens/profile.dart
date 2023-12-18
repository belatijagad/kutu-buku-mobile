// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kutubuku/utils/constants.dart';
import 'package:kutubuku/screens/edit_profile.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<dynamic> getUser() async {
      final response = await request.get(Constants.getUser);
      return response;
    }

    getUser().then((value) => {
          if (mounted && _username != value['display_name']) setState(() {
            _username = value['display_name'];
          })
        });

    return Scaffold(
      backgroundColor: const Color(0xFFC2F4E3),
      drawer: const Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Selamat Membaca!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                _username,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EditProfile();
                }));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await request.logout(Constants.logout);
                if (response['status'] == true) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        const SnackBar(content: Text("Selamat Tinggal.")));
                  Navigator.pushReplacementNamed(context, '/landing');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
