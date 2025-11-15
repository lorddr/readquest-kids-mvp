import 'package:flutter/material.dart';
import 'screens/library_screen.dart';

void main() {
  runApp(const ReadQuestApp());
}

class ReadQuestApp extends StatelessWidget {
  const ReadQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadQuest Kids',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'ComicSans',
        useMaterial3: true,
      ),
      home: const LibraryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}