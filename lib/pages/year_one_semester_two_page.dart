  
import 'package:flutter/material.dart';
import 'course_details_page.dart'; // Adjust the import path accordingly

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
            title: const Text('OPERATING SYSTEMS'),
            subtitle: const Text('course code: CSC1102'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Operating Systems',
                    courseCode: 'CSC1102',
                    description:
                        'Introduction to Operating Systems.',
                    lecturer: 'Prof. John Doe',
                    schedule: 'Mondays and Wednesdays, 9:00 AM - 11:00 AM',
                    pdfUrl: 'https://example.com/path_to_pdf.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('PROBABILITY AND STATISTICS'),
            subtitle: const Text('course code: CSC1103'),
            onTap: () {
              Navigator.push(
   context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Probability and Statistics',
                    courseCode: 'CSC1103',
                    description:
                        'Study of Probability and Statistics.',
                    lecturer: 'Dr. Ngubiri',
                    schedule: 'Tuesdays and Thursdays, 1:00 PM - 3:00 PM',
                    pdfUrl: 'https://example.com/path_to_pdf2.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('DATA STRUCTURES AND ALGORITHMS'),
            subtitle: const Text('course code: CSK1101'),
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Data Structures and Algorithms',
                    courseCode: 'CSK1101',
                    description:
                        'Data Structures and Algorithms for academic and professional Learning.',
                    lecturer: 'Mr Kizito ',
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