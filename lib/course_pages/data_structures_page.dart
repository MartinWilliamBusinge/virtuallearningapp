// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class DataStructuresPage extends StatefulWidget {
  const DataStructuresPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataStructuresPageState createState() =>
      _DataStructuresPageState();
}

class _DataStructuresPageState
    extends State<DataStructuresPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  Map<String, bool> topicCompletion = {};
  List<String> topics = [
    "Introduction to Probability",
    "Random Variables",
    "Probability Distributions",
    "Statistical Inference",
    "Regression Analysis",
  ];

  late Future<void> _loadTopicCompletionFuture;

  @override
  void initState() {
    super.initState();
    _loadTopicCompletionFuture = _loadTopicCompletion();
  }

  Future<void> _loadTopicCompletion() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Courses')
          .doc('DataStructures')
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          for (String topic in topics) {
            topicCompletion[topic] = data['topicCompletion']?[topic] ?? false;
          }
        });
      } else {
        // Initialize topicCompletion if document doesn't exist
        setState(() {
          for (String topic in topics) {
            topicCompletion[topic] = false;
          }
        });
      }
    } catch (e) {
      print('Error loading topic completion: $e');
    }
  }

  Future<void> _updateTopicCompletion(String topic, bool isCompleted) async {
    setState(() {
      topicCompletion[topic] = isCompleted;
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Courses')
        .doc('DataStructures')
        .set({
      'topicCompletion': topicCompletion,
    }, SetOptions(merge: true));
  }

  Future<void> _uploadFile(String folderName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;

      try {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('DataStructures/$folderName/$fileName');

        await ref.putFile(file);

        String downloadURL = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('DataStructures')
            .doc(folderName)
            .collection('files')
            .add({
          'fileName': fileName,
          'url': downloadURL,
        });

        setState(() {});
      } catch (e) {
        print('Error uploading file: $e');
      }
    } else {
      print('File selection canceled.');
    }
  }

  Future<void> _addVideoURL() async {
    final TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add YouTube Video URL'),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(labelText: 'URL'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String url = urlController.text;

                if (url.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('DataStructures')
                      .doc('videos')
                      .collection('urls')
                      .add({'url': url});

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  List<DocumentSnapshot> _filterResources(
      List<DocumentSnapshot> resources, String query) {
    if (query.isEmpty) {
      return resources;
    }

    return resources.where((resource) {
      var data = resource.data() as Map<String, dynamic>;
      var fileName = data['fileName'] ?? '';
      var url = data['url'] ?? '';
      return fileName.toLowerCase().contains(query.toLowerCase()) ||
          url.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Widget _buildFileSection(String folderName) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _uploadFile(folderName),
          child: const Text('Upload Useful File Here'),
        ),
        const SizedBox(height: 8),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('DataStructures')
              .doc(folderName)
              .collection('files')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            var files = _filterResources(snapshot.data!.docs, searchQuery);

            return ListView.builder(
              shrinkWrap: true,
              itemCount: files.length,
              itemBuilder: (context, index) {
                var file = files[index];
                var fileName = file['fileName'];
                var fileURL = file['url'];

                return ListTile(
                  title: Text(fileName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () {
                          _launchURL(fileURL);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          _launchURL(fileURL);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _addVideoURL,
          child: const Text('Add YouTube Video URL'),
        ),
        const SizedBox(height: 8),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Data Structures')
              .doc('videos')
              .collection('urls')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            var videos = _filterResources(snapshot.data!.docs, searchQuery);

            return ListView.builder(
              shrinkWrap: true,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                var video = videos[index];
                var url = video['url'];

                return ListTile(
                  title: const Text('YouTube Video'),
                  subtitle: Text(url),
                  onTap: () {
                    _launchURL(url);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCourseTopicsSection() {
    var filteredTopics = topics.where((topic) {
      return topic.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Column(
      children: filteredTopics.map((topic) {
        return CheckboxListTile(
          title: Text(topic),
          value: topicCompletion[topic],
          onChanged: (bool? value) {
            _updateTopicCompletion(topic, value!);
          },
        );
      }).toList(),
    );
  }

  Widget _buildUsefulContactsSection() {
    return Column(
      children: [
        ListTile(
          title: const Text('Lecturer'),
          subtitle: const Text('Dr. John Ngubiri'),
          trailing: const Icon(Icons.contact_phone),
          onTap: () {
            // Handle contact action
          },
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Structures and Algorithms'),
      ),
      body: FutureBuilder<void>(
        future: _loadTopicCompletionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search_outlined),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Description goes here ....',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Useful Resources',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    _buildFileSection('notes'),
                    const SizedBox(height: 16),
                    const Text(
                      'Past Papers',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    _buildFileSection('Pastpapers'),
                    const SizedBox(height: 16),
                    const Text(
                      'Videos',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    _buildVideoSection(),
                    const SizedBox(height: 16),
                    const Text(
                      'Course Topics',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    _buildCourseTopicsSection(),
                    const SizedBox(height: 16),
                    const Text(
                      'Useful Contacts',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    _buildUsefulContactsSection(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
