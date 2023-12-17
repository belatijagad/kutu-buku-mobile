import 'package:flutter/material.dart';
import 'dart:math';

class SearchBarWidget extends StatelessWidget {
  final String selectedGenre;
  final String selectedRating;
  final List<String> genres;
  final Function(String?) onGenreChanged;
  final Function(String?) onRatingChanged;
  final Function(String) onSearchChanged;
  final Function() toggleSort;
  final bool descending;

  final TextEditingController searchController;

  const SearchBarWidget({
    super.key,
    required this.selectedGenre,
    required this.selectedRating,
    required this.genres,
    required this.onGenreChanged,
    required this.onRatingChanged,
    required this.onSearchChanged,
    required this.searchController,
    required this.toggleSort,
    required this.descending,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            const Text(
              'Mau baca buku apa hari ini?',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari buku di sini!',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    // onSubmitted: onSearch,
                    onChanged: onSearchChanged,
                  ),
                ),
                IconButton(
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: descending
                        ? Matrix4.rotationX(0)
                        : Matrix4.rotationX(pi),
                    child: const Icon(Icons.sort),
                  ),
                  onPressed: toggleSort,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown for Rating
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedRating,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: onRatingChanged,
                      items: ['Terpopuler', 'Rating Tertinggi', 'Terbaru']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Dropdown for Genre
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedGenre,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: onGenreChanged,
                      items:
                          genres.map<DropdownMenuItem<String>>((String value) {
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
