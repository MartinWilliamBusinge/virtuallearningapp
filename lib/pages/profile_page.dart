import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' My Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Header image wrapped in a Container with specified dimensions
                      SizedBox(
                        width: 250,
                        height: 150,
                        child: Image.asset(
                          'lib/images/header_image.png',
                          fit: BoxFit
                              .cover, // Adjust the image to cover the container
                        ),
                      ),
                      // Profile Picture
                      const SizedBox(height: 50),
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            'lib/images/default_profile_picture.png'),
                      ),
                      // Profile information
                      const ListTile(
                        leading: Icon(Icons.person),
                        title: Text('FIRSTNAME: NAKIRIJJA'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.person),
                        title: Text('OTHER NAMES: Jessica'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.info),
                        title: Text('BIO:  computer science student'),
                      ),
                      // Telephone
                      const ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('CONTACTS: 0760421435/0753031959'),
                      ),
                      // Gender
                      const ListTile(
                        leading: Icon(Icons.person),
                        title: Text('GENDER: Female'),
                      ),
                     // Email
                    const ListTile(
                      leading: Icon(Icons.email),
                      title: Text('EMAIL: jessicanakirijja90@gmail.com'),
                     ),
                      // Button to edit profile
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      ),
                    ],
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
