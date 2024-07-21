import 'package:flutter/material.dart';
import 'package:virtuallearningapp/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:virtuallearningapp/components/theme_notifier.dart';
import 'package:virtuallearningapp/components/language_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier(ThemeData.light())),
        ChangeNotifierProvider(create: (_) => LanguageNotifier(const Locale('en', 'US'))), // Default to English
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier,LanguageNotifier>(
      builder: (context, themeNotifier, languageNotifier, child) {
        return MaterialApp(
          
          theme: themeNotifier.getTheme(),
          locale: languageNotifier.currentLocale,
          supportedLocales: const [
            Locale('en', 'US'), // English
            Locale('es', 'ES'), // Spanish
            Locale('it', 'IT'), // Italian
            Locale('sw', 'KE'), // Swahili
            Locale('zh', 'CN'), // Chinese
            Locale('de', 'DE'), // German
            Locale('nl', 'NL'), // Dutch
            Locale('fr', 'FR'), // French
            // Add more locales as needed
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: const AuthPage(), // Start with the authentication page

        );
      },
    );
  }
}
