import 'package:flutter/material.dart';
import 'course_details_page.dart'; // Import the course details page

class YearOneSemesterTwoPage extends StatelessWidget {
  const YearOneSemesterTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SEMESTER TWO")),
        backgroundColor: Colors.blueGrey,
         ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: [
          ListTile(
            title: const Text('Operating-Systems'),
            subtitle: const Text('course code: CSC1102'),
            onTap: () {
              // Navigate to CourseDetailsPage with specific details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Operating Systems',
                    courseCode: 'CSC1102',
    ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Probability and Statistics'),
            subtitle: const Text('course code: CSC1103'),
            onTap: () {
              // Navigate to CourseDetailsPage with specific details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Probability and Statistics',
                    courseCode: 'CSC1103',
     ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Data Structures and Algorithms'),
            subtitle: const Text('course code: CSK1101'),
            onTap: () {
              // Navigate to CourseDetailsPage with specific details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Data Structures and Algorithms',
                    courseCode: 'CSK1101',
        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}                                              