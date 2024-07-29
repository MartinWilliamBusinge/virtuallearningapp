import 'package:flutter/material.dart';
import 'package:virtuallearningapp/course_pages/automata_page.dart';
import 'package:virtuallearningapp/course_pages/research_methodology_page.dart';
import 'package:virtuallearningapp/course_pages/software_verification_page.dart';

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
            title: const Text('RESEARCH METHODOLOGY'),
            subtitle: const Text('course code: CSC 1102'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResearchMethodologyPage(
                    
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('AUTOMATA, COMPLEXITY AND COMPATIBILITY'),
            subtitle: const Text('course code: CSC 2210'),
            onTap: () {
              Navigator.push(
   context,
                MaterialPageRoute(
                  builder: (context) => const AutomataPage(
                    
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('SOFTWARE VERIFICATION'),
            subtitle: const Text('course code: CSK 1101'),
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(
                  builder: (context) => const SoftwareVerificationPage(
                    
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