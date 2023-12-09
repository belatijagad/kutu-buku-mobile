import 'package:flutter/material.dart';
import 'package:kutubuku/widgets/book_card_widget.dart';
import 'package:kutubuku/widgets/searchbar.dart';

class SearchBookScreen extends StatefulWidget {
  @override
  _SearchBookScreenState createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchBookScreen> {
  String selectedGenre = 'Genre';
  String selectedRating = 'Rating tertinggi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Image.asset(
            "assets/images/kutubuku1.png",
            fit: BoxFit.contain,
            width: 200,
            height: 200,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
            },
            child: Text(
              'Log in',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 4),
          ElevatedButton(
            onPressed: () {
            },
            child: Text('Sign up'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF3BEDB7),
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        color: Color.fromARGB(65, 59, 237, 184),
        child: Column(
          children: [
            SizedBox(height: 8),
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
                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
