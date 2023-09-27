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

  void sendMessage() async {
    String userMessage = messageController.text;
    setState(() {
      chatMessages.add('Tú: $userMessage');
      messageController.clear();
    });
    
    //192.168.64.1    127.0.0.1
    final response = await http.post(
      Uri.http('localhost:3000', '/message'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'text': userMessage}),
    );

    if(response.statusCode == 200){
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String assistantResponse = responseBody['output']['generic'][0]['text'];
      print(responseBody);
      setState(() {
        chatMessages.add('Asistente: $assistantResponse');
      });

    }else{
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