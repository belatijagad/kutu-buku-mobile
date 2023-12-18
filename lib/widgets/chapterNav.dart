import 'package:flutter/material.dart';

class ChapterNavigationControls extends StatelessWidget {
  final int currentChapter;
  final int totalChapters;
  final ValueChanged<int> onNavigate;

  const ChapterNavigationControls({
    Key? key,
    required this.currentChapter,
    required this.totalChapters,
    required this.onNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Previous Chapter Button
        if (currentChapter > 1)
          OutlinedButton(
            onPressed: () => onNavigate(currentChapter - 1),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios, size: 16),
                Text('Prev'),
              ],
            ),
          ),

        // Next Chapter Button
        if (currentChapter < totalChapters)
          OutlinedButton(
            onPressed: () => onNavigate(currentChapter + 1),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Next'),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
      ],
    );
  }
}
