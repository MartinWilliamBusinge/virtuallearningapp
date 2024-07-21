import 'package:flutter/material.dart';
import 'package:virtuallearningapp/services/chat_gpt_service.dart';

class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  _AIPageState createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  final TextEditingController _controller = TextEditingController();
  final ChatGPTService _chatGPTService = ChatGPTService();
  String _response = '';
  bool _isLoading = false;

  void _getResponse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _chatGPTService.getResponse(_controller.text);
      setState(() {
        _response = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _response = 'Response cannot be processed currently. Please try again later.';
        _isLoading = false;
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Response:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(_response),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask a question...',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _getResponse,
                      ),
                    ),
                    onSubmitted: (value) => _getResponse(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _getResponse,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
