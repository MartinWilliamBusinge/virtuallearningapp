import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsPage extends StatelessWidget {
  final String courseName;
  final String courseCode;
  final String description;
  final String lecturer;
  final String schedule;
  final String pdfUrl; // URL or path to the PDF

  const CourseDetailsPage({super.key, 
    required this.courseName,
    required this.courseCode,
    required this.description,
    required this.lecturer,
    required this.schedule,
    required this.pdfUrl,
     });

  Future<void> _launchPDF(String url) async {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Course Code: $courseCode',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
           const SizedBox(height: 10),
           const Text(
              'Description:',
              style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
           const SizedBox(height: 10),
           const Text(
              'Lecturer:',
              style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              lecturer,
              style: const TextStyle(fontSize: 16),
            ),
           const SizedBox(height: 10),
           const Text(
              'Schedule:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              schedule,
              style: const TextStyle(fontSize: 16),
            ),
           const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchPDF(pdfUrl); // Open the PDF when button is pressed
              },
              child: const Text('View Course PDF'),
            ),
          ],
        ),
      ),
    );
}
 