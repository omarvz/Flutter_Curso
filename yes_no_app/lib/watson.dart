import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});
  
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];

  final String assistantApiKey = 'bvSdFW8xBKNvvjxaxnaroG-O9vE5qXO3bRMbkTTMz1dB';
  final String assistantUrl = 'https://api.au-syd.assistant.watson.cloud.ibm.com/instances/3ef1bfba-a374-4b3f-aaaa-0451f3de05dc/v2';
  final String assistantId = '3796a67d-0664-4d9f-9f5b-10882210cd78';

  void sendMessage() async {
    String userMessage = messageController.text;
    setState(() {
      chatMessages.add('Tú: $userMessage');
      messageController.clear();
    });

    // Realiza una solicitud POST a Watson Assistant
    final response = await http.post(
      Uri.parse(assistantUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $assistantApiKey',
      },
      body: jsonEncode({'input': {'text': userMessage}}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String assistantResponse = responseBody['output']['generic'][0]['text'];
      setState(() {
        chatMessages.add('Asistente: $assistantResponse');
      });
    } else {
      setState(() {
        chatMessages.add('Error al conectar con el asistente.');
        chatMessages.add(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat con Watson Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe tu mensaje...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
