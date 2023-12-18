import 'package:flutter/material.dart';
import 'package:kutubuku/models/book.dart';
import 'package:kutubuku/screens/book_detail.dart';
import 'package:kutubuku/utils/constants.dart';
import 'package:kutubuku/widgets/progressBar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class bookmarkCardWidget extends StatefulWidget {
  final Book book;

  const bookmarkCardWidget({
    super.key,
    required this.book,
  });

  @override
  _bookmarkCardWidgetState createState() => _bookmarkCardWidgetState();
}

class _bookmarkCardWidgetState extends State<bookmarkCardWidget> {
  bool isBookmarked = false;
  int currentChapterRead = 0;
  dynamic lastRead;

  @override
  void initState() {
    super.initState();
    fetchReadingProgress(); // Fetch reading progress when the widget is initialized.
  }

  Future<void> fetchReadingProgress() async {
    final request = context.read<CookieRequest>();
    final response = await request.get(Constants.getProgress(widget.book.pk));
    if (response['statusCode'] == 200) {
      setState(() {
        currentChapterRead = response['current_chapter'];
        lastRead = response['last_read'];
      });
    } else {
      // Handle errors or show some default value.
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final book = widget.book;

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
                          '$currentChapterRead/${book.fields.chapters} chapter terbaca'),
                      const SizedBox(height: 4),
                      buildProgressBar(
                          currentChapterRead, book.fields.chapters),
                      const SizedBox(height: 4),
                      Text('Terakhir membaca $lastRead'),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
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
                            'Lanjut Membaca',
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
        ],
      ),
    );
  }
}
