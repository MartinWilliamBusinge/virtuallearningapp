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
        title: const Center(child: Text("SEMESTER ONE")),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: [
          ListTile(
            title: const Text('ARTIFICIAL INTELLIGENCE'),
            subtitle: const Text('Course Code: CSC1102'),
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
            title: const Text('DISCRETE MATH'),
            subtitle: const Text('Course Code: CSK1101'),
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
