// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kutubuku/utils/constants.dart';

class ReviewForm extends StatefulWidget {
  final int bookId;
  final String currentUser;
  final Function onReviewSubmitted;
  final Function onReviewDeleted;

  const ReviewForm({
    super.key,
    required this.bookId,
    required this.currentUser,
    required this.onReviewSubmitted,
    required this.onReviewDeleted,
  });

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int selectedRating = 0;
  TextEditingController reviewController = TextEditingController();
  bool hasExistingReview = false;
  int? existingReviewId;

  @override
  void initState() {
    super.initState();
    _fetchUserReview();
  }

  Future<void> _fetchUserReview() async {
    final request = context.read<CookieRequest>();

    if (request.loggedIn) {
      final response = await request.get(Constants.getReview(widget.bookId));
      if (response['status'] == 'success') {
        setState(() {
          selectedRating = response['review']['rating'];
          reviewController.text = response['review']['comment'];
          hasExistingReview = true;
          existingReviewId = response['review']['id'];
        });
      } else {
        setState(() {
          selectedRating = 0;
          reviewController.text = '';
          hasExistingReview = false;
          existingReviewId = null;
        });
      }
    }
  }

  Widget _buildReviewInput() {
    return TextField(
      readOnly: hasExistingReview,
      controller: reviewController,
      decoration: const InputDecoration(
        labelText: 'Ulasan Anda',
        border: OutlineInputBorder(),
      ),
      maxLines: 4,
    );
  }

  Future<void> submitReview(int bookId, int rating, String comment) async {
    final request = context.read<CookieRequest>();
    final response = await request.postJson(
      Constants.submitReview(bookId),
      jsonEncode({
        'rating': rating,
        'comment': comment,
      }),
    );

    widget.onReviewSubmitted();
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: selectedRating > 0 && reviewController.text.isNotEmpty
          ? () {
              if (widget.currentUser == '') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Tolong masuk untuk menambahkan ulasan."),
                ));
              } else if (!hasExistingReview) {
                submitReview(
                    widget.bookId, selectedRating, reviewController.text);
                _fetchUserReview();
              } else {
                widget.onReviewDeleted(existingReviewId);
                _fetchUserReview();
              }
            }
          : null,
      child: Text(hasExistingReview ? 'Hapus Ulasan' : 'Kirim Ulasan'),
    );
  }

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
            if (!hasExistingReview) {
              setState(() {
                selectedRating = index + 1;
              });
            }
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hasExistingReview ? 'Ulasan Anda' : 'Tulis sebuah ulasan!'),
        _buildStarRating(),
        const SizedBox(height: 8),
        _buildReviewInput(),
        const SizedBox(height: 8),
        _buildSubmitButton(),
      ],
    );
  }
}
