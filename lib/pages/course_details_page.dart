import 'package:flutter/material.dart';

class CourseDetailsPage extends StatelessWidget {
  final String courseName;
  final String courseCode;

  CourseDetailsPage({required this.courseName, required this.courseCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
   child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(courseName),
            Text(courseCode),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}     