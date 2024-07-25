import 'package:flutter/material.dart';
import 'course_details_page.dart'; // Adjust the import path accordingly

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
            title: const Text('OBJECT-ORIENTED PROGRAMMING'),
            subtitle: const Text('COURSE CODE: CSC1102'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Object-Oriented Programming',
                    courseCode: 'CSC1102',
                    description:
                        'Introduction to object-oriented programming principles and practices.',
                    lecturer: 'Mr Lwomwa Joseph',
                    schedule: 'Mondays and Wednesdays, 9:00 AM - 11:00 AM',
                    pdfUrl: 'https://example.com/path_to_pdf.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('COMPUTER ARCHITECTURE'),
            subtitle: const Text('COURSE CODE: CSC1103'),
            onTap: () {
              Navigator.push(
   context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Computer Architecture',
                    courseCode: 'CSC1103',
                    description:
                        'Study of computer organization and architecture.',
                    lecturer: 'Mrs Babrah',
                    schedule: 'Tuesdays and Thursdays, 1:00 PM - 3:00 PM',
                    pdfUrl: 'https://example.com/path_to_pdf2.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('COMMUNICATION SKILLS'),
            subtitle: const Text('COURSE CODE: CSK1101'),
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    courseName: 'Communication Skills',
                    courseCode: 'CSK1101',
                    description:
                        'Developing effective communication skills for academic and professional Learning.',
                    lecturer: 'Mrs Katushemererwe Fridah',
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