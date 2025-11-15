import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../models/story.dart';

class ReadingScreen extends StatefulWidget {
  final Story story;
  const ReadingScreen({super.key, required this.story});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = "";
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
      _wordsSpoken = "";
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final correctText = widget.story.textAsr.toLowerCase().replaceAll('.', '').replaceAll(',', '');
    final spokenText = _wordsSpoken.toLowerCase().replaceAll('.', '').replaceAll(',', '');
    final accuracy = correctText.isEmpty ? 0 : (spokenText.split(' ').where((w) => correctText.contains(w)).length / correctText.split(' ').length * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
        backgroundColor: Colors.orange[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Ilustrație cu placeholder gri
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.story.illustrationUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('🖼️', style: TextStyle(fontSize: 80)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Textul poveștii
            Text(
              widget.story.textDisplay,
              style: const TextStyle(fontSize: 18, height: 1.6),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),

            // Buton ASR
            ElevatedButton.icon(
              onPressed: _speechEnabled
                  ? (_isListening ? _stopListening : _startListening)
                  : null,
              icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
              label: Text(_isListening ? "Oprește" : "Citește cu voce tare"),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isListening ? Colors.red[400] : Colors.green[400],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Feedback
            if (_wordsSpoken.isNotEmpty)
              Column(
                children: [
                  const Text("Ai spus:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_wordsSpoken, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(
                    "Precizie: $accuracy%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accuracy > 80 ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}