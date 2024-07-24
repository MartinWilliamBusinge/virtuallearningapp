import 'package:flutter/material.dart';

class PastPaperDetailsPage extends StatelessWidget {
  final String paperTitle;

  PastPaperDetailsPage({required this.paperTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paperTitle),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Details for $paperTitle',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}