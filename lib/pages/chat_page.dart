import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = []; // List to store messages and their types
  final TextEditingController _controller = TextEditingController(); // Controller for the text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()), // Extracted method for message list
          _buildMessageInput(), // Extracted method for message input
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildMessageBubble(messages[index]);
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    bool isSentByMe = message['isSentByMe'];
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message['text'],
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your message here...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.lightGreenAccent,
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: const TextStyle(color: Colors.black),
              onSubmitted: (message) {
                _sendMessage(); // Updated to call _sendMessage method
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage, // Updated to call _sendMessage method
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text,
          'isSentByMe': true, // Assuming all sent messages are by the user
        });
        _controller.clear(); // Clear the text field
      });

      // For demonstration, simulate receiving a message
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          messages.add({
            'text': 'This is a received message',
            'isSentByMe': false,
          });
        });
      });
    }
  }
}
