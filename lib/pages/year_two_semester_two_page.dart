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
        backgroundColor: const Color.fromARGB(255, 159, 47, 173),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: ListView(
        children: [
          ListTile(
<<<<<<< HEAD
            title: const Text('RESEARCH METHODOLOGY',style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSC 1102', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
=======
            title: const Text('RESEARCH METHODOLOGY'),
            subtitle: const Text('Course Code: CSC 1102'),
>>>>>>> e3c2a8be09670611be810d656783331729505269
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
<<<<<<< HEAD
            title: const Text('AUTOMATA, COMPLEXITY AND COMPATIBILITY', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSC 2210', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
=======
            title: const Text('AUTOMATA, COMPLEXITY AND COMPATIBILITY'),
            subtitle: const Text('Course Code: CSC 2210'),
>>>>>>> e3c2a8be09670611be810d656783331729505269
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
<<<<<<< HEAD
            title: const Text('SOFTWARE VERIFICATION', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSK 1101', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
=======
            title: const Text('SOFTWARE VERIFICATION'),
            subtitle: const Text('Course Code: CSK 1101'),
>>>>>>> e3c2a8be09670611be810d656783331729505269
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