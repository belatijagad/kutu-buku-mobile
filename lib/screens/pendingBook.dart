// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:kutubuku/utils/constants.dart';

import 'package:kutubuku/widgets/pendingBookCard.dart';
import 'package:kutubuku/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class PendingBookScreen extends StatefulWidget {
  const PendingBookScreen({super.key});

  @override
  _PendingBookScreenState createState() => _PendingBookScreenState();
}

class _PendingBookScreenState extends State<PendingBookScreen> {
  List<Book> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    try {
      final bookList = await fetchBooks();
      setState(() {
        books = bookList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching books: $e');
    }
  }

  Future deleteBook(int id) async {
    final request = context.read<CookieRequest>();
    final response = request.get(Constants.deleteBook(id));
    loadBooks();
  }

  Future approveBook(int id) async {
    final request = context.read<CookieRequest>();
    final response = request.get(Constants.approveBook(id));
    loadBooks();
  }

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(Constants.pendingBooks));

    if (response.statusCode == 200) {
      return bookFromJson(response.body);
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buku Menunggu Persetujuan'),
      ),
      body: Container(
        color: const Color.fromARGB(65, 59, 237, 184),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: books.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return PendingBookCardWidget(
                          key: ValueKey(book),
                          book: book,
                          onApprove: approveBook,
                          onReject: deleteBook,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
