import 'package:flutter/material.dart';
import 'course_details_page.dart'; // Adjust the import path accordingly

class YearTwoSemesterTwoPage extends StatelessWidget {
  const YearTwoSemesterTwoPage({super.key});

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
            title: const Text('Research Methodology'),
            subtitle: const Text('course code: CSC1102'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Research Methodology',
                    courseCode: 'CSC1102',
                    description:
                        'Introduction to Research Methodology.',
                    instructor: 'Prof. John Doe',
                    schedule: 'Mondays and Wednesdays, 9:00 AM - 11:00 AM',
                    pdfUrl: 'https://example.com/path_to_pdf.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Robotics'),
            subtitle: const Text('course code: CSC1103'),
            onTap: () {
              Navigator.push(
   context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Robotics',
                    courseCode: 'CSC1103',
                    description:
                        'Study of Robotics.',
                    instructor: 'Dr. Ngubiri',
                    schedule: 'Tuesdays and Thursdays, 1:00 PM - 3:00 PM',
                    pdfUrl: 'https://example.com/path_to_pdf2.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Software Verification'),
            subtitle: const Text('course code: CSK1101'),
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Software Verification',
                    courseCode: 'CSK1101',
                    description:
                        'Software Verification for academic and professional Learning.',
                    instructor: 'lecturer: Mr Kizito',
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