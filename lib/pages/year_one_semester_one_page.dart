
import 'package:flutter/material.dart';

class YearOneSemesterOnePage extends StatelessWidget {
  const YearOneSemesterOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SEMESTER ONE")),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: [
          ListTile(
            title: const Text('Object-Oriented Programming'),
            subtitle: const Text('course code:CSC1102'),
            onTap:(){},
         ),
            
             ListTile(
            title: const Text('Computer Architecture'),
            subtitle: const Text('course code:CSC1103'), 
            onTap: () {},
          ),
          ListTile(
            title: const Text('Communication Skills'), 
            subtitle: const Text('course code:CSK1101'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
              
            
            
            
            
          
        
          
          
      
    
  
