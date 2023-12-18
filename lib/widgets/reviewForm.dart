import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kutubuku/utils/constants.dart';

class ReviewForm extends StatefulWidget {
  final int bookId;
  final String currentUser;
  final Function onReviewSubmitted;

  const ReviewForm(
      {super.key,
      required this.bookId,
      required this.currentUser,
      required this.onReviewSubmitted});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int selectedRating = 0;
  String reviewText = "";

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < selectedRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              selectedRating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildReviewInput() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Your Review',
        border: OutlineInputBorder(),
      ),
      maxLines: 4,
      onChanged: (value) {
        reviewText = value;
      },
    );
  }

  Future<void> submitReview(int bookId, int rating, String comment) async {
    final request = context.read<CookieRequest>();
    // ignore: unused_local_variable
    final response = await request.postJson(
      Constants.submitReview(bookId),
      jsonEncode(
        {
          'rating': rating,
          'comment': comment,
        },
      ),
    );
    // if (response.['statusCode'] == 201) {
    //   print('Review submitted successfully');
    // } else {
    //   print('Failed to submit review: ${response.body}');
    // }
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: selectedRating > 0 && reviewText.isNotEmpty
          ? () {
              if (widget.currentUser == '') {
                print("login dulu");
              } else {
                submitReview(widget.bookId, selectedRating, reviewText);
                widget.onReviewSubmitted();
              }
            }
          : null,
      child: const Text('Submit Review'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStarRating(),
        const SizedBox(height: 8),
        _buildReviewInput(),
        const SizedBox(height: 8),
        _buildSubmitButton(),
      ],
    );
  }
}
