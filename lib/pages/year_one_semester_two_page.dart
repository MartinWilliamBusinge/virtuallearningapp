  
import 'package:flutter/material.dart';
import 'package:virtuallearningapp/course_pages/data_structures_page.dart';
import 'package:virtuallearningapp/course_pages/operating_systems_page.dart';
import 'package:virtuallearningapp/course_pages/probability_and_statistics_page.dart';

class YearOneSemesterTwoPage extends StatelessWidget {
  const YearOneSemesterTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SEMESTER TWO", style: TextStyle(color: Color.fromARGB(255, 247, 245, 245)))),
        backgroundColor:const Color.fromARGB(255, 159, 47, 173),
      ),
      backgroundColor: const Color.fromARGB(255, 242, 243, 243),
      body: ListView(
        children: [
          ListTile(
            title: const Text('OPERATING SYSTEMS', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSC 1102', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OperatingSystemsPage(
                    
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('PROBABILITY AND STATISTICS', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSC 1103', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
            onTap: () {
              Navigator.push(
   context,
                MaterialPageRoute(
                  builder: (context) => const ProbabilityAndStatisticsPage(
                    
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('DATA STRUCTURES AND ALGORITHMS', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSK 1101', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(
                  builder: (context) => const DataStructuresPage(
                    
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