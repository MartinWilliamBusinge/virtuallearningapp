import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({super.key});

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  TextEditingController _userInput = TextEditingController();
  static const apiKey = "AIzaSyBMLqFYO-iH4Ccr1JgMmMIEPDcuQR_ov2E";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<Message> _messages = [];
  late final String userId;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('gemini_messages')
        .doc(userId)
        .collection('messages')
        .orderBy('date')
        .get();
    setState(() {
      _messages.addAll(snapshot.docs
          .map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    });
  }

  Future<void> _saveMessage(Message message) async {
    await FirebaseFirestore.instance
        .collection('gemini_messages')
        .doc(userId)
        .collection('messages')
        .add(message.toJson());
  }

  Future<void> sendMessage() async {
    final message = _userInput.text;
    if (message.trim().isEmpty) {
      return;
    }

    final userMessage =
        Message(isUser: true, message: message, date: DateTime.now());
    setState(() {
      _messages.add(userMessage);
    });
    _userInput.clear(); // Clear the text box
    await _saveMessage(userMessage); // Save user message to Firestore

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    final botMessage = Message(
        isUser: false, message: response.text ?? "", date: DateTime.now());
    setState(() {
      _messages.add(botMessage);
    });
    await _saveMessage(botMessage); // Save bot response to Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("C H A T   B O T")),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      backgroundColor: Colors.orange.shade200,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true, // Ensure the latest message is visible
              child: Column(
                children: _messages.map((message) {
                  return Messages(
                    isUser: message.isUser,
                    message: message.message,
                    date: DateFormat('HH:mm').format(message.date),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _userInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: const Text('Enter Your Message'),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  padding: const EdgeInsets.all(12),
                  iconSize: 30,
                  onPressed: () {
                    sendMessage();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});

  Map<String, dynamic> toJson() => {
        'isUser': isUser,
        'message': message,
        'date': date.toIso8601String(),
      };

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      isUser: json['isUser'],
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? Colors.blueAccent : Colors.grey.shade400,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
          topRight: const Radius.circular(10),
          bottomRight: isUser ? Radius.zero : const Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
                fontSize: 16, color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(
                fontSize: 10, color: isUser ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
