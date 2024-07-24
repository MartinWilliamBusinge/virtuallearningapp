import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtuallearningapp/components/language_selection_dialog.dart';
import 'package:virtuallearningapp/components/theme_notifier.dart';
import 'package:virtuallearningapp/pages/profile_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      appBar: AppBar(
        title: const Center(child: Text("S E T T I N G S")),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin:
                const EdgeInsets.all(3.0), // Adds margin around the container
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Change Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin:
                const EdgeInsets.all(3.0), // Adds margin around the container
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.brightness_4),
              title: const Text('Change Mode'),
              onTap: () {
                ThemeNotifier themeNotifier =
                    Provider.of<ThemeNotifier>(context, listen: false);
                themeNotifier.setTheme(
                  Theme.of(context).brightness == Brightness.dark
                      ? ThemeData.light()
                      : ThemeData.dark(),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin:
                const EdgeInsets.all(3.0), // Adds margin around the container
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Notifications'),
                      content: const Text('Coming Soon  😁'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin:
                const EdgeInsets.all(3.0), // Adds margin around the container
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('App Language'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(' Select App Language'),
                      content: const LanguageSelectionDialog(),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


