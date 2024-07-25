import 'package:flutter/material.dart';
import 'course_details_page.dart'; // Adjust the import path accordingly

class YearTwoSemesterOnePage extends StatelessWidget {
  const YearTwoSemesterOnePage({super.key});

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
            title: const Text('ARTIFICIAL INTELLIGENCE'),
            subtitle: const Text('course code: CSC1102'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Artificial Intelligence',
                    courseCode: 'CSC1102',
                    description: 'Introduction to Artificial Intelligence.',
                    lecturer: 'Prof. John Doe',
                    schedule: 'Mondays and Wednesdays, 9:00 AM - 11:00 AM',
                    pdfUrl: 'https://example.com/path_to_pdf.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('COMPUTER NETWORKS'),
            subtitle: const Text('course code: CSC1103'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Computer Networks',
                    courseCode: 'CSC1103',
                    description: 'Study of Computer Networks.',
                    lecturer: 'Dr. Ngubiri',
                    schedule: 'Tuesdays and Thursdays, 1:00 PM - 3:00 PM',
                    pdfUrl: 'https://example.com/path_to_pdf2.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('DISCRETE MATH'),
            subtitle: const Text('course code: CSK1101'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Discrete Math',
                    courseCode: 'CSK1101',
                    description:
                        'Discrete Math for academic and professional Learning.',
                    lecturer: ' Mr Kizito',
                    schedule: 'Fridays, 10:00 AM - 12:00 PM',
                    pdfUrl: 'https://example.com/path_to_pdf3.pdf',
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
