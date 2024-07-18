import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning Download Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DownloadPage(),
    );
  }
}

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final Map<int, List<DownloadItem>> yearItems = {
    1: [
      DownloadItem(title: 'Year 1 - Operating System', url: 'https://example.com/year1/operatingsystem.zip'),
      DownloadItem(title: 'Year 1 - Probability and Statistics', url: 'https://example.com/year1/probabilityandstatistics.zip'),
    ],
    2: [
      DownloadItem(title: 'Year 2 - Database Management System', url: 'https://example.com/year2/databasemanagementsystem.zip'),
      DownloadItem(title: 'Year 2 - Discrete Mathematics', url: 'https://example.com/year2/discretemathematics.zip'),
    ],
  };

  int selectedYear = 1;
  final Dio dio = Dio();

  Future<void> startDownload(DownloadItem item) async {
    setState(() {
      item.status = DownloadStatus.downloading;
    });

    final tempDir = Directory.systemTemp.path;
    final savePath = '$tempDir/${item.title}.zip';

    try {
      await dio.download(
        item.url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              item.progress = received / total;
            });
          }
        },
      );
      setState(() {
        item.status = DownloadStatus.completed;
      });
    } catch (e) {
      setState(() {
        item.status = DownloadStatus.failed;
        item.errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<int>(
              value: selectedYear,
              onChanged: (int? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
              },
              items: yearItems.keys.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('Year $value'),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: yearItems[selectedYear]!.length,
              itemBuilder: (context, index) {
                final item = yearItems[selectedYear]![index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(value: item.progress),
                      const SizedBox(height: 8),
                      Text(
                        item.status == DownloadStatus.downloading
                            ? 'Downloading... ${(item.progress * 100).toStringAsFixed(0)}%'
                            : item.status == DownloadStatus.completed
                                ? 'Download completed'
                                : item.status == DownloadStatus.failed
                                    ? 'Download failed: ${item.errorMessage}'
                                    : 'Tap to download',
                        style: TextStyle(
                          color: item.status == DownloadStatus.failed
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  trailing: item.status == DownloadStatus.notStarted ||
                          item.status == DownloadStatus.failed
                      ? IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            startDownload(item);
                          },
                        )
                      : item.status == DownloadStatus.completed
                          ? const Icon(Icons.check, color: Colors.green)
                          : const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DownloadItem {
  final String title;
  final String url;
  double progress;
  DownloadStatus status;
  String? errorMessage;

  DownloadItem({
    required this.title,
    required this.url,
    this.progress = 0.0,
    this.status = DownloadStatus.notStarted,
    this.errorMessage,
  });
}

enum DownloadStatus { notStarted, downloading, completed, failed }
