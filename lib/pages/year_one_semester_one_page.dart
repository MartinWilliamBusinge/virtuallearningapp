import 'package:flutter/material.dart';
import 'package:virtuallearningapp/course_pages/communication_skills_page.dart';
import 'package:virtuallearningapp/course_pages/computer_architecture_page.dart';
import 'package:virtuallearningapp/course_pages/opp_page.dart';

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
                  builder: (context) => const OOPPage(),
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
                  builder: (context) => const ComputerArchitecturePage(),
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
                  builder: (context) => const CommunicationSkillsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
