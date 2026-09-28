import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xylophone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const XylophoneScreen(),
    );
  }
}

class XylophoneScreen extends StatelessWidget {
  const XylophoneScreen({super.key});

  // Hàm phát âm thanh: đầu vào là số thứ tự của phím đàn
  void playSound(int noteNumber) {
    final player = AudioPlayer();
    // AssetSource tự thêm tiền tố "assets/" nên chỉ cần ghi tên file
    player.play(AssetSource('sound/note$noteNumber.wav'));
    // Giải phóng player sau khi phát xong
    player.onPlayerComplete.listen((_) => player.dispose());
  }

  // Hàm dựng một phím đàn
  Widget buildKey({required Color color, required int noteNumber}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(),
        ),
        onPressed: () => playSound(noteNumber),
        child: Text(
          'Nốt $noteNumber',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Xylophone'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildKey(color: Colors.red, noteNumber: 1),
            buildKey(color: Colors.orange, noteNumber: 2),
            buildKey(color: Colors.yellow.shade700, noteNumber: 3),
            buildKey(color: Colors.green, noteNumber: 4),
            buildKey(color: Colors.teal, noteNumber: 5),
            buildKey(color: Colors.blue, noteNumber: 6),
            buildKey(color: Colors.purple, noteNumber: 7),
          ],
        ),
      ),
    );
  }
}