
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YearOnePage extends StatelessWidget {
  const YearOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Year One'),
      ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: [
          ListTile(
            title: const Text('Object-Oriented Programming'),
            subtitle: const Text('Python example'),
            onTap:(){ _launchURL('https://youtu.be/RSl87lqOXDE?si=U74nNLK9o41HUGnI');},
         ),
            ListTile(
            title: const Text('Mathematics for Computer Science'),
            subtitle: const Text('Python example'),
            onTap: (){},
          ),
          ListTile(
            title: const Text('Computer Literacy'),
            subtitle: const Text('Basic HTML example'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Computer Architecture'),
            subtitle: const Text('C example'), 
            onTap: () {},
          ),
          ListTile(
            title: const Text('Communication Skills'), 
            subtitle: const Text('Modules'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Digital Innovation and Computational Thinking'),
            subtitle: const Text('Python example'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
              
            
            
            
            
          
        
          
          
      
    
  
