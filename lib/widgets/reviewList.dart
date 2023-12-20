// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kutubuku/widgets/reviewCard.dart';

class ReviewList extends StatefulWidget {
  final int bookId;
  final bool isSuperUser;
  final Function onReviewDeleted;
  Future<List<dynamic>> reviewsFuture;

  ReviewList({
    Key? key,
    required this.bookId,
    required this.isSuperUser,
    required this.onReviewDeleted,
    required this.reviewsFuture,
  }) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
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
              bool isSuperUser = widget.isSuperUser;
              return ReviewCard(
                username: review['user'],
                initialScore: review['upvotes'] - review['downvotes'],
                date: review['created_at'],
                comment: review['comment'],
                rating: review['rating'],
                reviewId: review['id'],
                isSuperUser: isSuperUser,
                onDelete: () => widget.onReviewDeleted(review['id']),
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
