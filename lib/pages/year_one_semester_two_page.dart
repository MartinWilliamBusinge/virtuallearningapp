  
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
        title: const Center(child: Text("SEMESTER TWO")),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: [
          ListTile(
            title: const Text('OPERATING SYSTEMS'),
            subtitle: const Text('Course Code: CSC 1102'),
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
            title: const Text('PROBABILITY AND STATISTICS'),
            subtitle: const Text('Course Code: CSC 1103'),
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
            title: const Text('DATA STRUCTURES AND ALGORITHMS'),
            subtitle: const Text('Course Code: CSK 1101'),
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