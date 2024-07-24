import 'package:flutter/material.dart';
import 'past_papers.dart';

class CourseDetailsPage extends StatelessWidget {
  final String courseName;
  final String courseCode;
   final List<String> pastPapers;



  CourseDetailsPage({required this.courseName, required this.courseCode,required this.pastPapers});

  //@override
  //Widget build(BuildContext context) {
    //return Scaffold(
      //appBar: AppBar(
        //title: Text(courseName),
        //backgroundColor: Colors.blueGrey,
      //),
      //body: Center(
   //child: Column(
     //     mainAxisAlignment: MainAxisAlignment.center,
       //   children: <Widget>[
         //   Text(courseName),
           // Text(courseCode),
            
            // Add more details as needed
          //],
        //),
      //),
    //);
 // }
//} 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Code: $courseCode',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Course Description:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'This is a placeholder for the course description.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Past Papers:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ...pastPapers.map((paper) => ListTile(
              title: Text(
                paper,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to the past paper details page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PastPaperDetailsPage(paperTitle: paper),
                  ),
                );
              },
            )).toList(),
          ],
        ),
      ),
    );
  }
}
 