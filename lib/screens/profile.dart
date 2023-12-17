import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kutubuku/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final Function? onLogout;

  const ProfileScreen({super.key, this.onLogout});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndLoadUserData();
  }

  Future<void> _fetchAndLoadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      _userData = fetchUserDetails(username);
    } else {
      // Handle the scenario where there is no saved username
    }
    setState(() {
      _loading = false;
    });
  }

  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse(Constants.getUser(username)));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data: ${response.body}');
    }
  }

  Future<void> _logout(BuildContext context) async {
    widget.onLogout!();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'username'); // Assuming 'username' is the key for stored username

    // Navigate to the login screen
    Navigator.of(context)
        .pushReplacementNamed('/login'); // Adjust the route as necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<Map<String, dynamic>>(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Username: ${snapshot.data!['username']}'),
                        ElevatedButton(
                          onPressed: () => _logout(context),
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("User data not found"),
                  );
                }
              },
            ),
    );
  }
}
