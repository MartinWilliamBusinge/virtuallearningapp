// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String _fullName = '';
  String _studentNumber = '';
  String _courseName = '';
  String _yearOfStudy = '';
  String _telephoneContact = '';
  String _emailAddress = '';
  String? _profileImageUrl;
  bool _isLoading = true;
  bool _hasData = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot profile =
          await _firestore.collection('Profiles').doc(user.uid).get();
      if (profile.exists) {
        setState(() {
          _fullName = profile['fullName'];
          _studentNumber = profile['studentNumber'];
          _courseName = profile['courseName'];
          _yearOfStudy = profile['yearOfStudy'];
          _telephoneContact = profile['telephoneContact'];
          _emailAddress = profile['emailAddress'];
          _profileImageUrl = profile['profileImageUrl'];
          _hasData = true;
        });
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("                     P R O F I L E"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      backgroundColor: Colors.deepPurple.shade500,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: _hasData
                  ? ListView(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                    as ImageProvider
                                : null,
                            child: _profileImageUrl == null
                                ? const Icon(Icons.person,
                                    size: 50, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDisplayField(
                            label: 'Full Name', value: _fullName),
                        const SizedBox(height: 16),
                        _buildDisplayField(
                            label: 'Student Number', value: _studentNumber),
                        const SizedBox(height: 16),
                        _buildDisplayField(
                            label: 'Course Name', value: _courseName),
                        const SizedBox(height: 16),
                        _buildDisplayField(
                            label: 'Year of Study', value: _yearOfStudy),
                        const SizedBox(height: 16),
                        _buildDisplayField(
                            label: 'Telephone Contact',
                            value: _telephoneContact),
                        const SizedBox(height: 16),
                        _buildDisplayField(
                            label: 'Email Address', value: _emailAddress),
                        const SizedBox(height: 16),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'No profile data found😢. \n Please visit SETTINGS and select Change Profile to set up your profile.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
            ),
    );
  }

  Widget _buildDisplayField({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 48, 18, 7),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
