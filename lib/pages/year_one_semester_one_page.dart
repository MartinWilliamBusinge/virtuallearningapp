import 'package:flutter/material.dart';
import 'course_details_page.dart'; // Import the course details page

class YearOneSemesterOnePage extends StatelessWidget {
  const YearOneSemesterOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SEMESTER ONE")),
        backgroundColor: Colors.blueGrey,
         ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: [
          ListTile(
            title: const Text('Object-Oriented Programming'),
            subtitle: const Text('course code: CSC1102'),
            onTap: () {
              // Navigate to CourseDetailsPage with specific details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Object-Oriented Programming',
                    courseCode: 'CSC1102',
    ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Computer Architecture'),
            subtitle: const Text('course code: CSC1103'),
            onTap: () {
              // Navigate to CourseDetailsPage with specific details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Computer Architecture',
                    courseCode: 'CSC1103',
     ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Communication Skills'),
            subtitle: const Text('course code: CSK1101'),
            onTap: () {
              // Navigate to CourseDetailsPage with specific details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Communication Skills',
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