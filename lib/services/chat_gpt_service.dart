import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String _apiKey = 'YOUR OPEN AI API KEY';
  final String _model = 'gpt2';

  Future<String> getResponse(String prompt) async {
    final refinedPrompt = 'You are an AI assistant. Please provide clear, concise, and accurate information: $prompt';
    final url = Uri.parse('https://api-inference.huggingface.co/models/$_model');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({'inputs': refinedPrompt}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody[0]['generated_text'] ?? 'Error: No response';
    } else {
      return 'Error: Unable to process the request';
    }
  }
}
