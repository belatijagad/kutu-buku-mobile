// ignore_for_file: file_names, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kutubuku/models/book.dart';
import 'package:kutubuku/screens/book_detail.dart';
import 'package:kutubuku/utils/constants.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookCardWidget extends StatefulWidget {
  final Book book;

  const BookCardWidget({
    super.key,
    required this.book,
  });

  @override
  _BookCardWidgetState createState() => _BookCardWidgetState();
}

class _BookCardWidgetState extends State<BookCardWidget> {
  bool isBookmarked = false;

  @override
  void initState() {
    final request = context.read<CookieRequest>();
    super.initState();
    if (request.loggedIn) {
      checkBookmark();
    }
  }

  Future<void> checkBookmark() async {
    final request = context.read<CookieRequest>();
    final response = await request.get(Constants.checkBookmark(widget.book.pk));
    if (response['is_bookmarked']) {
      setState(() {
        isBookmarked = true;
      });
    }
  }

  Future<void> toggleBookmark() async {
    final request = context.read<CookieRequest>();
    final response =
        await request.post(Constants.bookmarkBook(widget.book.pk), {});

    if (response['statusCode'] == 200) {
      setState(() {
        isBookmarked = !isBookmarked;
      });
    } else {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error bookmarking book"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final book = widget.book;

    List<Widget> genreWidgets = book.fields.genre
        .take(2) // Take only the first three genres
        .map<Widget>((genre) => Chip(
              label: Text(genre),
              padding: const EdgeInsets.all(4),
            ))
        .toList();

    // If there are more than three genres, add ellipses
    if (book.fields.genre.length > 2) {
      genreWidgets
          .add(const Chip(label: Text('...'), padding: EdgeInsets.all(4)));
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Image.network(
                  book.fields.imgSrc,
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              book.fields.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.fields.author ??
                            book.fields.user?.username ??
                            'No Author',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: genreWidgets,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double
                            .infinity, // This makes the button take the full width of its parent.
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(book: book),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          child: const Text(
                            'Baca',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                size: 40,
              ),
              color: isBookmarked
                  ? const Color(0xFF3BEDB7)
                  : const Color(0xFF3BEDB7),
              onPressed: () async {
                bool loggedIn = request.loggedIn;
                if (loggedIn) {
                  await toggleBookmark();
                } else {
                  // Show message or navigate to login screen
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text("Tolong masuk untuk menambahkan daftar baca."),
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
