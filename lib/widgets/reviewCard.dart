import 'package:flutter/material.dart';
import 'package:kutubuku/utils/constants.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatefulWidget {
  final String username;
  final int initialScore;
  final String date;
  final String comment;
  final int rating;
  final int reviewId;
  final VoidCallback onDelete;

  const ReviewCard({
    Key? key,
    required this.username,
    required this.initialScore,
    required this.date,
    required this.comment,
    required this.rating,
    required this.onDelete,
    required this.reviewId,
  }) : super(key: key);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late int score;
  int voteStatus = 0;

  @override
  void initState() {
    super.initState();
    score = widget.initialScore;
    getVoteStatus();
  }

  void getVoteStatus() async {
    final request = context.read<CookieRequest>();
    final response =
        await request.get(Constants.getVoteStatus(widget.reviewId));
    if (response['voteStatus'] == 'upvote') {
      setState(() {
        voteStatus = 1;
      });
    } else if (response['voteStatus'] == 'downvote') {
      setState(() {
        voteStatus = -1;
      });
    }
  }

  void _upvote() async {
    final request = context.read<CookieRequest>();
    if (request.loggedIn) {
      final response =
          await request.get(Constants.upvoteReview(widget.reviewId));
      if (response['status'] == 'success') {
        setState(() {
          if (voteStatus == -1) {
            score += 2;
          } else {
            score += 1;
          }
          voteStatus = 1;
        });
      }
    }
  }

  void _downvote() async {
    final request = context.read<CookieRequest>();
    if (request.loggedIn) {
      final response =
          await request.get(Constants.downvoteReview(widget.reviewId));
      if (response['status'] == 'success') {
        setState(() {
          if (voteStatus == 1) {
            score -= 2;
          } else {
            score -= 1;
          }
          voteStatus = -1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8), // Add some padding to the container
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 16),
                    Text(widget.date),
                  ],
                ),
              ),
              Text('$score'),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.arrow_upward,
                  color: voteStatus == 1 ? Colors.green : Colors.grey,
                  size: 16,
                ),
                onPressed: _upvote,
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_downward,
                  color: voteStatus == -1 ? Colors.red : Colors.grey,
                  size: 16,
                ),
                onPressed: _downvote,
              ),
            ],
          ),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < widget.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(widget.comment),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implement report functionality
              },
              child: Text('Report', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}
