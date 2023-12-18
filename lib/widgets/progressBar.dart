// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget buildProgressBar(int chaptersRead, int totalChapters) {
  double progress = chaptersRead / totalChapters;
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 8,
          ),
        ),
      ],
    ),
  );
}
