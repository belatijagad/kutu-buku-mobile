import 'package:flutter/material.dart';
import 'package:kutubuku/models/book.dart';
import 'package:kutubuku/screens/book_detail.dart';

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
  Widget build(BuildContext context) {
    final book = widget.book.fields;

    List<Widget> genreWidgets = book.genre
        .take(2) // Take only the first three genres
        .map<Widget>((genre) => Chip(
              label: Text(genre),
              padding: const EdgeInsets.all(4),
            ))
        .toList();

    // If there are more than three genres, add ellipses
    if (book.genre.length > 2) {
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
                  book.imgSrc,
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
                              book.title,
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
                        book.author ?? book.user?.username ?? 'No Author',
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
                                builder: (context) =>
                                    DetailScreen(bookField: book),
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
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
