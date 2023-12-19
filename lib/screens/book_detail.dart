// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';

import 'package:kutubuku/models/book.dart';
import 'package:kutubuku/screens/novelChapter.dart';
import 'package:kutubuku/utils/constants.dart';
import 'package:kutubuku/widgets/reviewForm.dart';
import 'package:kutubuku/widgets/reviewList.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Book book;
  const DetailScreen({
    super.key,
    required this.book,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final int itemsPerPage = 10;
  int currentPage = 1;
  String _username = '';
  late Future<List<dynamic>> _reviewsFuture;

  List<int> displayedChapters = [];

  @override
  void initState() {
    super.initState();
    loadChapters();
    _reviewsFuture = fetchReviews(widget.book.pk);
  }

  void loadChapters() {
    int totalChapters = widget.book.fields.chapters;
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    endIndex = endIndex > totalChapters ? totalChapters : endIndex;

    setState(() {
      displayedChapters =
          List.generate(endIndex - startIndex, (i) => startIndex + i + 1);
    });
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
      loadChapters();
    });
  }

  void updateReviews() {
    setState(() {
      _reviewsFuture = fetchReviews(widget.book.pk);
    });
  }

  Future<void> deleteReview(int reviewId) async {
    final request = context.read<CookieRequest>();
    final response = await request.get(Constants.deleteReview(reviewId));

    if (response['statusCode'] == 200) {
      updateReviews();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete review')),
      );
    }
  }

  Future<List<dynamic>> fetchReviews(int bookId) async {
    final request = context.read<CookieRequest>();

    final response = await request.get(Constants.fetchReview(bookId));
    return response['reviews'];
  }

  Future<void> updateReadingProgress(int chapterNumber) async {
    final request = context.read<CookieRequest>();

    try {
      final response = await request
          .get(Constants.updateProgress(widget.book.pk, chapterNumber));

      if (response['statusCode'] == 200) {
        print('Progress updated: ${response['current_chapter']}');
      } else {
        print('Failed to update progress: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating progress: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookField = widget.book.fields;

    List<Widget> genreWidgets = bookField.genre
        .map<Widget>((genre) => Chip(
              label: Text(genre),
              padding: const EdgeInsets.all(4),
            ))
        .toList();

    Widget _buildChapterGrid() {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
        ),
        itemCount: displayedChapters.length,
        itemBuilder: (BuildContext context, int index) {
          int chapterNumber = displayedChapters[index];
          return InkWell(
            onTap: () {
              updateReadingProgress(chapterNumber);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterScreen(
                    bookName: widget.book.fields.title,
                    chapter: chapterNumber,
                    totalChapters: widget.book.fields.chapters,
                    updateProgress: updateReadingProgress,
                  ),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text('Chapter $chapterNumber'),
              ),
            ),
          );
        },
      );
    }

    final request = context.watch<CookieRequest>();
    Future<dynamic> getUser() async {
      final response = await request.get(Constants.getUser);
      return response;
    }

    if (request.loggedIn) {
      getUser().then(
        (value) => {
          if (_username != value['username'])
            {
              setState(() {
                _username = value['username'];
              })
            }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        bookField.imgSrc,
                        width: 120,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.bookmark,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            ...List.generate(5, (index) {
                              final starNumber = index + 1;
                              final filledThreshold = starNumber * 20;
                              final halfFilledThreshold = filledThreshold - 10;

                              if (bookField.averageScore >= filledThreshold) {
                                return const Icon(Icons.star,
                                    color: Colors.amber);
                              } else if (bookField.averageScore >=
                                  halfFilledThreshold) {
                                return const Icon(Icons.star_half,
                                    color: Colors.amber);
                              } else {
                                return const Icon(Icons.star_border,
                                    color: Colors.amber);
                              }
                            }),
                            Text(
                                '${((bookField.averageScore / 20.0).toStringAsFixed(2))}/5.0'),
                          ]),
                          Text(
                            bookField.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            bookField.author ?? bookField.user ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Genre'),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12.0,
                    runSpacing: 8.0,
                    children: genreWidgets,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Synopsis'),
                  Text(
                    bookField.synopsis,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Chapters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  _buildChapterGrid(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: currentPage > 1
                            ? () => changePage(currentPage - 1)
                            : null,
                      ),
                      Text(
                          'Page $currentPage of ${(bookField.chapters / itemsPerPage).ceil()}'),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: currentPage <
                                (bookField.chapters / itemsPerPage).ceil()
                            ? () => changePage(currentPage + 1)
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Reviews'),
                  ReviewForm(
                    bookId: widget.book.pk,
                    currentUser: _username,
                    onReviewSubmitted: updateReviews,
                    onReviewDeleted: deleteReview,
                  ),
                  ReviewList(
                    bookId: widget.book.pk,
                    currentUser: _username,
                    onReviewDeleted: deleteReview,
                    reviewsFuture: _reviewsFuture,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
