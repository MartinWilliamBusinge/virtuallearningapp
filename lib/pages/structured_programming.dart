import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class DetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String url;

  const DetailPage({super.key, 
    required this.title,
    required this.subtitle,
    required this.url,
  });
  @override
  _DetailPageState createState() => _DetailPageState();

}

class _DetailPageState extends State<DetailPage> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subtitle,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL(widget.url),
              child: const Text('Open Resource'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadFile,
              child: const Text('Upload File'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: filePath != null ? downloadFile : null,
              child: const Text('Download File'),
            ),
          ],
        ),
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
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String? pickedFilePath = result.files.single.path;
      if (pickedFilePath != null) {
        String appDir = (await getApplicationDocumentsDirectory()).path;
        String fileName = pickedFilePath.split('/').last;
        File newFile = await File(pickedFilePath).copy('$appDir/$fileName');

        setState(() {
          filePath = newFile.path;
        });
      }
    }
  }
   void downloadFile() {
    if (filePath != null) {
      OpenFile.open(filePath!);
    }
  }
}

