// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _telephoneContactController =
      TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));
  bool isPlaying = false;

  String _yearOfStudy = 'Year One';
  File? _profileImage;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _studentNumberController.dispose();
    _courseNameController.dispose();
    _telephoneContactController.dispose();
    _emailAddressController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_profileImage == null) return;

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        Reference ref = _storage.ref().child('profile_images').child(user.uid);
        UploadTask uploadTask = ref.putFile(_profileImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          _profileImageUrl = downloadUrl;
        });
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _loadProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot profile =
          await _firestore.collection('Profiles').doc(user.uid).get();
      if (profile.exists) {
        setState(() {
          _fullNameController.text = profile['fullName'];
          _studentNumberController.text = profile['studentNumber'];
          _courseNameController.text = profile['courseName'];
          _yearOfStudy = profile['yearOfStudy'] ?? 'Year One';
          _telephoneContactController.text = profile['telephoneContact'];
          _emailAddressController.text = profile['emailAddress'];
          _profileImageUrl = profile['profileImageUrl'];
        });
      }
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      await _uploadImage();

      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('Profiles').doc(user.uid).set({
          'fullName': _fullNameController.text,
          'studentNumber': _studentNumberController.text,
          'courseName': _courseNameController.text,
          'yearOfStudy': _yearOfStudy,
          'telephoneContact': _telephoneContactController.text,
          'emailAddress': _emailAddressController.text,
          'profileImageUrl': _profileImageUrl,
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile saved!')));
        _playConfetti();
      }
    }
  }

  void _playConfetti() {
    if (isPlaying) {
      _confettiController.stop();
    } else {
      _confettiController.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.orange.shade200,
          appBar: AppBar(
            title: const Center(child: Text("E d i t    P r o f i l e")),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.grey,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                    as ImageProvider
                                : null,
                        child: _profileImage == null && _profileImageUrl == null
                            ? const Icon(Icons.add_a_photo,
                                size: 50, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextFieldContainer(
                    label: 'Full Name',
                    controller: _fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFieldContainer(
                    label: 'Student Number',
                    controller: _studentNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your student number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFieldContainer(
                    label: 'Course Name',
                    controller: _courseNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your course name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownFieldContainer(
                    label: 'Year of Study',
                    value: _yearOfStudy,
                    items: ['Year One', 'Year Two', 'Year Three'],
                    onChanged: (value) {
                      setState(() {
                        _yearOfStudy = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFieldContainer(
                    label: 'Telephone Contact',
                    controller: _telephoneContactController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your telephone contact';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFieldContainer(
                    label: 'Email Address',
                    controller: _emailAddressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: MaterialButton(
                      onPressed: _saveProfile,
                      color: Colors.deepPurple.shade300,
                      child: const Text('Save Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [Colors.red, Colors.blue, Colors.green, Colors.yellow],
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldContainer({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownFieldContainer({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : items[0],
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your year of study';
          }
          return null;
        },
      ),
    );
  }
}
