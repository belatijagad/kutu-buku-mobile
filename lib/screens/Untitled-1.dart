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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text("CKONASD"),
                              ],
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            Text(
                              bookField.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(bookField.author ?? bookField.user ?? ''),
                            Wrap(
                              spacing: 8.0, // Spacing between chips
                              children:
                                  genreWidgets, // Use the list of genre widgets here
                            ),
                            Text(
                              bookField.synopsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Mulai Membaca',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.blue,
                                      ),
                                    ],
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ingin mengulas buku ini?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Rating()]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(),
                                color: Colors.white,
                              ),
                              child: TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Your review...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade100,
                              ),
                              child: const Text('Kirim ulasan'),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ulasan Buku',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text('Urutkan berdasarkan'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: DropdownButton(
                              value: 'Reputasi',
                              items: const [
                                DropdownMenuItem(
                                  value: 'Reputasi',
                                  child: Text('Reputasi'),
                                ),
                                DropdownMenuItem(
                                  value: 'Tanggal Terbaru',
                                  child: Text('Tanggal Terbaru'),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                          FloatingActionButton(
                            child: const Icon(Icons.arrow_downward_rounded),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ini username',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Lorem ipsum',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16.0,
                                    ),
                                    Text(
                                      '12/10/2023',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              rating = index + 1;
            });
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_outline,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
