// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:kutubuku/utils/constants.dart';

import 'package:kutubuku/widgets/bookCard.dart';
import 'package:kutubuku/widgets/searchbar.dart';
import 'package:kutubuku/models/book.dart';
import 'package:kutubuku/models/genre.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchBookScreenState createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchScreen> {
  String selectedGenre = 'Genre';
  String selectedRating = 'Terpopuler';
  String searchQuery = '';
  String genreQuery = '';
  String sortQuery = 'popularity';
  bool descending = true;

  final TextEditingController _searchController = TextEditingController();
  List<String> genres = [];

  List<Book> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGenres().then((fetchedGenres) {
      setState(() {
        genres = fetchedGenres;
      });
    });
    loadBooks();
  }

  Future<void> loadBooks() async {
    try {
      String finalQuery = searchQuery;
      finalQuery += descending ? '&direction=desc' : '&direction=asc';
      if (genreQuery != '') {
        finalQuery += '&genre=$genreQuery';
      }

      if (sortQuery != '') {
        finalQuery += '&sort=$sortQuery';
      }

      final bookList = await fetchBooks(finalQuery);
      setState(() {
        books = bookList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching books: $e');
    }
  }

  Future<List<Book>> fetchBooks(String query) async {
    final response =
        await http.get(Uri.parse('${Constants.searchBooks}?q=$query'));

    if (response.statusCode == 200) {
      return bookFromJson(response.body);
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<String>> fetchGenres() async {
    final response = await http.get(Uri.parse(Constants.getGenres));

    if (response.statusCode == 200) {
      return ['Genre', ...genreFromJson(response.body)];
    } else {
      throw Exception('Failed to load books');
    }
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      isLoading = true;
    });
    loadBooks();
  }

  void onGenreChanged(String? newValue) {
    if (newValue != null && newValue != selectedGenre) {
      setState(() {
        genreQuery = newValue == 'Genre' ? '' : newValue;
        selectedGenre = newValue;
        isLoading = true;
      });
      loadBooks();
    }
  }

  void onRatingChanged(String? newValue) {
    if (newValue != null && newValue != selectedRating) {
      setState(() {
        if (newValue == 'Terpopuler') {
          sortQuery = 'popularity';
        } else if (newValue == 'Rating Tertinggi') {
          sortQuery = 'rating';
        } else if (newValue == 'Terbaru') {
          sortQuery = 'newest';
        } else {
          sortQuery = '';
        }

        selectedRating = newValue;
        isLoading = true;
      });
      loadBooks();
    }
  }

  void toggleSortOrder() {
    setState(() {
      descending = !descending;
    });
    loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(65, 59, 237, 184),
        child: Column(
          children: [
            const SizedBox(height: 8),
            SearchBarWidget(
              toggleSort: toggleSortOrder,
              searchController: _searchController,
              onSearchChanged: onSearchChanged,
              genres: genres,
              selectedGenre: selectedGenre,
              selectedRating: selectedRating,
              onGenreChanged: onGenreChanged,
              onRatingChanged: onRatingChanged,
              descending: descending,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator
                  : ListView.builder(
                      itemCount: books.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return BookCardWidget(
                            book: book); // Pass the book object to the widget
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
