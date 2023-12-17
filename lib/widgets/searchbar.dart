import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final double horizontalMargin;
  final String selectedGenre;
  final String selectedRating;
  final Function(String?) onGenreChanged;
  final Function(String?) onRatingChanged;

  SearchBarWidget({
    required this.horizontalMargin,
    required this.selectedGenre,
    required this.selectedRating,
    required this.onGenreChanged,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Text(
              'Mau baca buku apa hari ini?',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari buku di sini!',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: () {
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown for Rating
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedRating,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: onRatingChanged,
                      items: ['Rating tertinggi', 'Terpopuler', 'Terbaru']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Dropdown for Genre
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedGenre,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: onGenreChanged,
                      items: ['Genre', 'Action', 'Drama', 'Romance']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
