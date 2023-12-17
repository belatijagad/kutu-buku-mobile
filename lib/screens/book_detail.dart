// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:kutubuku/models/book.dart';

class DetailScreen extends StatefulWidget {
  final Fields bookField;
  const DetailScreen({
    super.key,
    required this.bookField,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final bookField = widget.bookField;

    List<Widget> genreWidgets = bookField.genre
        .map<Widget>((genre) => Chip(
              label: Text(genre),
              padding: const EdgeInsets.all(4),
            ))
        .toList();

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
                            Text('${(bookField.averageScore / 20.0)}/5.0'),
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
                  Text('Chapter'),
                ],
              ),
              Column(
                children: [
                  Text('Reviews'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
