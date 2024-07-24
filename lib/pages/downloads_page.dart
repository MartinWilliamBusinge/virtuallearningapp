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
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final List<DownloadItem> items = [
    DownloadItem(title: 'Operating System', url: 'https://example.com/operatingsystem.zip'),
    DownloadItem(title: 'Probability and Statistics', url: 'https://example.com/probabilityandstatistics.zip'),
    DownloadItem(title: 'SAAD', url: 'https://example.com/saad.zip'),
  ];

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
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
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

