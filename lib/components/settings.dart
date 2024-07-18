import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtuallearningapp/components/theme_notifier.dart';
import 'package:virtuallearningapp/components/language_notifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Change Profile'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Change Profile'),
                    content: const Text('Implement change profile functionality'),
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
          ListTile(
            leading: const Icon(Icons.brightness_4),
            title: const Text('Change Mode'),
            onTap: () {
              ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
              themeNotifier.setTheme(
                Theme.of(context).brightness == Brightness.dark ? ThemeData.light() : ThemeData.dark(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Notifications'),
                    content: const Text('Implement notifications settings functionality'),
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
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('App Language'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('App Language'),
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