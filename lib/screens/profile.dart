// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kutubuku/screens/addbook.dart';
import 'package:kutubuku/screens/bookmark.dart';
import 'package:kutubuku/screens/pendingBook.dart';
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
  bool _is_superuser = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<dynamic> getUser() async {
      final response = await request.get(Constants.getUser);
      return response;
    }

    getUser().then((value) {
      if (_username != value['username']) {
        setState(() {
          _username = value['username'];
          _is_superuser = value['is_superuser'];
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      body: ListView(
        children: [
          Container(
            color: Color(0xFFC2F4E3),
            child: Image.asset(
              "assets/images/Book Vector.png",
              width: 300,
              height: 300,
            ),
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 1,
            thickness: 1,
            indent: 0, // No padding on the left
            endIndent: 0, // No padding on the right
          ),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text(
              'Ubah Profil',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ),
              );
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 1,
            thickness: 1,
            indent: 0, // No padding on the left
            endIndent: 0, // No padding on the right
          ),
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text(
              'Daftar Membaca',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarkScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            title: const Text(
              'Tambah Buku',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookScreen(),
                ),
              );
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 1,
            thickness: 1,
            indent: 0, // No padding on the left
            endIndent: 0, // No padding on the right
          ),
          if (_is_superuser) ...[
            // ListTile(
            //   leading: const Icon(Icons.report),
            //   title: const Text(
            //     'Laporan Pengguna',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontFamily: 'Montserrat',
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const ReviewReportScreen(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.library_books_rounded),
              title: const Text(
                'Buku Menunggu Persetujuan',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PendingBookScreen(),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.grey.shade200,
              height: 1,
              thickness: 1,
              indent: 0, // No padding on the left
              endIndent: 0, // No padding on the right
            ),
          ],
          ElevatedButton(
            onPressed: () async {
              final response = await request.logout(Constants.logout);
              if (response['status'] == true) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                      const SnackBar(content: Text("Berhasil keluar.")));
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
    );
  }
}
