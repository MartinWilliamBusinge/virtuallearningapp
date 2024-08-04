import 'package:flutter/material.dart';
import 'package:virtuallearningapp/course_pages/artificial_intelligence_page.dart';
import 'package:virtuallearningapp/course_pages/computer_networks_page.dart';
import 'package:virtuallearningapp/course_pages/discrete_math_page.dart';

class YearTwoSemesterOnePage extends StatelessWidget {
  const YearTwoSemesterOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SEMESTER ONE", style: TextStyle(color: Color.fromARGB(255, 247, 245, 245)))),
        backgroundColor:const Color.fromARGB(255, 159, 47, 173),
      ),
      backgroundColor: const Color.fromARGB(255, 242, 243, 243),
      body: ListView(
        children: [
          ListTile(
            title: const Text('ARTIFICIAL INTELLIGENCE', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSC1102', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArtificialIntelligencePage(
                    
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('COMPUTER NETWORKS'),
            subtitle: const Text('Course Code: CSC1103'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComputerNetworksPage(
                    
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('DISCRETE MATH', style: TextStyle(color: Colors.red)),
            subtitle: const Text('course code: CSK1101', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiscreteMathPage(
                    
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
