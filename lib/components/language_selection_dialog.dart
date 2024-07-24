import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtuallearningapp/components/language_notifier.dart';

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