import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kutubuku/widgets/chapterNav.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class ChapterScreen extends StatefulWidget {
  final String bookName;
  final int chapter;
  final int totalChapters;
  final Function updateProgress;
  const ChapterScreen({
    super.key,
    required this.bookName,
    required this.chapter,
    required this.totalChapters,
    required this.updateProgress,
  });

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                  'Chapter ${widget.chapter}: ${loremIpsum(words: random.nextInt(5) + 3)}'),
              ChapterNavigationControls(
                currentChapter: widget.chapter,
                totalChapters: widget.totalChapters,
                onNavigate: (chapter) => _navigateToChapter(context, chapter),
              ),
              Text(loremIpsum(words: 669, paragraphs: 5, initWithLorem: true)),
              ChapterNavigationControls(
                currentChapter: widget.chapter,
                totalChapters: widget.totalChapters,
                onNavigate: (chapter) => _navigateToChapter(context, chapter),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToChapter(BuildContext context, int chapter) {
    widget.updateProgress(chapter);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChapterScreen(
          bookName: widget.bookName,
          chapter: chapter,
          totalChapters: widget.totalChapters,
          updateProgress: widget.updateProgress,
        ),
      ),
    );
  }
}
