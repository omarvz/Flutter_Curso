import 'package:flutter/material.dart';
import 'package:yes_no_app_v2/config/theme/app_theme.dart';
import 'package:yes_no_app_v2/presentation/screens/chat/chat_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yes No App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme( selectedColor: 1 ).theme(),
      home: const ChatScreen(),
    );
  }
}
