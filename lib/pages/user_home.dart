import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtuallearningapp/components/my_button.dart';
import 'package:virtuallearningapp/pages/contact_us_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  String? fullName; // Add a property to hold the user's full name

  @override
  void initState() {
    super.initState();
    _fetchUserFullName();
  }

  // Fetch the user's full name from Firestore
  Future<void> _fetchUserFullName() async {
    final doc = await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        fullName = data['fullName'];
      });
    } else {
      setState(() {
        fullName = "FRIEND";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'HELLO ${fullName ?? 'LOADING...'} \n WELCOME TO QUICK LEARN APP \u{1F600} \n FEEL AT HOME \u{2764}\u{FE0F}',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 23,
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
              MyButton(
                text: "C O N T A C T     U S",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactUsPage(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
