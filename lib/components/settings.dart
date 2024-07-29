import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtuallearningapp/components/theme_notifier.dart';
import 'package:virtuallearningapp/components/language_notifier.dart';
import 'package:virtuallearningapp/pages/profile_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 247),
      appBar: AppBar(
        title: const Center(child: Text("S E T T I N G S")),
        backgroundColor: Colors.transparent,
        foregroundColor: Color.fromARGB(255, 167, 82, 141),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin:
                const EdgeInsets.all(3.0), // Adds margin around the container
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 153, 59, 117),
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Change Profile', style: TextStyle(color: Color.fromARGB(255, 247, 245, 245))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const ProfilePage()),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin:
                const EdgeInsets.all(3.0), // Adds margin around the container
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 150, 43, 123),
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.brightness_4),
              title: const Text('Change Mode', style: TextStyle(color: Color.fromARGB(255, 252, 251, 250))),
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
              color: Color.fromARGB(255, 148, 49, 135),
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications', style: TextStyle(color: Color.fromARGB(255, 250, 248, 248))),
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
              color: Color.fromARGB(255, 145, 42, 122),
              borderRadius: BorderRadius.circular(
                  10), // Adjust the value to get the desired roundness
            ),
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('App Language', style: TextStyle(color: Color.fromARGB(255, 240, 236, 236))),
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

class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageNotifier>(
      builder: (context, languageNotifier, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                languageNotifier.setLocale(const Locale('en', 'US'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Spanish'),
              onTap: () {
                languageNotifier.setLocale(const Locale('es', 'ES'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Italian'),
              onTap: () {
                languageNotifier.setLocale(const Locale('it', 'IT'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Swahili'),
              onTap: () {
                languageNotifier.setLocale(const Locale('sw', 'KE'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Chinese'),
              onTap: () {
                languageNotifier.setLocale(const Locale('zh', 'CN'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('German'),
              onTap: () {
                languageNotifier.setLocale(const Locale('de', 'DE'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Dutch'),
              onTap: () {
                languageNotifier.setLocale(const Locale('nl', 'NL'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('French'),
              onTap: () {
                languageNotifier.setLocale(const Locale('fr', 'FR'));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
