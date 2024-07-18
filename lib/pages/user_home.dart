import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quick Learn App',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'HELLO WELCOME TO QUICK LEARN APP \u{1F600} \n FEEL AT HOME \u{2764}\u{FE0F}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Recent Pages',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5, // Assuming 5 recent pages for this example
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Recent Page ${index + 1}',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        'Description of recent page ${index + 1}',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        // Handle navigation to the specific recent page
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown, // Brown color for "Contact Us"
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: const Text(
                    'Email us: jessicanakirijja90@gmail.com\n Call us: +256 760 421 435 / +256 753 031 959',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Colors.brown, // Brown color for contact information
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: UserHomePage()));
