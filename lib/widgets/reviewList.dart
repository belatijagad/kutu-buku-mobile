// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kutubuku/utils/constants.dart';

class ReviewList extends StatefulWidget {
  final int bookId;
  final String currentUser;
  final Function onReviewDeleted;
  Future<List<dynamic>> reviewsFuture;

  ReviewList({
    Key? key,
    required this.bookId,
    required this.currentUser,
    required this.onReviewDeleted,
    required this.reviewsFuture,
  }) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<void> deleteReview(int reviewId) async {
    final request = context.read<CookieRequest>();
    final response = await request.get(Constants.deleteReview(reviewId));

    if (response['statusCode'] == 200) {
      widget.onReviewDeleted();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete review')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<dynamic> reviews = snapshot.data!;
          return ListView.builder(
            itemCount: reviews.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var review = reviews[index];
              bool isUserReview = review['user'] == widget.currentUser;

              return ListTile(
                title: Text(review['user']),
                subtitle: Text(review['comment']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      5,
                      (i) => Icon(
                        i < review['rating'] ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                    if (isUserReview)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteReview(review['id']),
                      ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Text('No reviews found');
        }
      },
    );
  }
}
