// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kutubuku/widgets/book_card_widget.dart';
import 'package:kutubuku/widgets/searchbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchBookScreenState createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchScreen> {
  String selectedGenre = 'Genre';
  String selectedRating = 'Rating tertinggi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(65, 59, 237, 184),
        child: Column(
          children: [
            const SizedBox(height: 8),
            SearchBarWidget(
              horizontalMargin: 16.0,
              selectedGenre: selectedGenre,
              selectedRating: selectedRating,
              onGenreChanged: (newValue) {
                setState(() {
                  selectedGenre = newValue!;
                });
              },
              onRatingChanged: (newValue) {
                setState(() {
                  selectedRating = newValue!;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemBuilder: (context, index) {
                  return BookCardWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
