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
        title: const Center(child: Text("SEMESTER TWO", style: TextStyle(color: Color.fromARGB(255, 247, 245, 245)))),
        backgroundColor: Color.fromARGB(255, 159, 47, 173),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: ListView(
        children: [
          ListTile(
            title: const Text('RESEARCH METHODOLOGY',style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSC 1102', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
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
            title: const Text('AUTOMATA, COMPLEXITY AND COMPATIBILITY', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSC 2210', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
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
            title: const Text('SOFTWARE VERIFICATION', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSK 1101', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
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