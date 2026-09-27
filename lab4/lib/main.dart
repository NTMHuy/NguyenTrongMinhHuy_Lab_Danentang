import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 ball',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const MagicBallScreen(),
    );
  }
}

// StatefulWidget vì cần thay đổi giao diện (ảnh/câu trả lời) khi người dùng bấm nút
class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  // Biến lưu trạng thái: số thứ tự câu trả lời hiện tại
  int ballNumber = 1;

  // Danh sách câu trả lời tương ứng (tùy chọn, dùng kèm ảnh hoặc thay ảnh)
  final List<String> answers = [
    'Chắc chắn rồi!',
    'Không nên đâu.',
    'Có thể lắm.',
    'Hỏi lại sau nhé.',
    'Rất tiếc là không.',
  ];

  void _rollBall() {
    // Sử dụng dart:math để tạo số ngẫu nhiên
    final generator = Random();

    setState(() {
      // Tạo số ngẫu nhiên từ 1 đến số lượng ảnh (ở đây là 5)
      ballNumber = generator.nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magic 8 Ball'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị ảnh quả cầu tương ứng với trạng thái hiện tại
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                'assets/images/ball.png',
                height: 250,
              ),
            ),
            const SizedBox(height: 12),

            // Hiển thị câu trả lời dạng text (song song với ảnh)
            Text(
              answers[ballNumber - 1],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Nút bấm để lắc quả cầu
            ElevatedButton(
              onPressed: _rollBall,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Lắc quả cầu',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}