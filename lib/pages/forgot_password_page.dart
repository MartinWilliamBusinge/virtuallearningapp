// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtuallearningapp/services/auth_services.dart';
// Import the AuthService

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();  // Create an instance of AuthService
  String _feedbackMessage = '';

  void _resetPassword() async {
    try {
      await _authService.sendPasswordResetEmail(_emailController.text);
      setState(() {
        _feedbackMessage = 'Password reset email sent. Check your inbox.';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _feedbackMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 167, 184, 192),
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your email address to reset your password',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Reset Password'),
            ),
            const SizedBox(height: 16),
            Text(
              _feedbackMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
