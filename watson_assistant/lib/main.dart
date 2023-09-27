import 'package:flutter/material.dart';
import 'package:watson_assistant/chat_screen.dart';
import 'dart:io';

void main() {
  runApp(const MaterialApp(
    home: ChatScreen()
  ));
}




/* void main() {
  // Configura la versión de TLS/SSL que deseas utilizar.
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

  // Realiza tu solicitud HTTP con el httpClient configurado.
} */

