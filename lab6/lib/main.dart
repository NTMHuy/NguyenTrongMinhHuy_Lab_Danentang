import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: const Text('Quizzler'),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

// StatefulWidget vì câu hỏi hiện tại và điểm số thay đổi theo người dùng
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Danh sách biểu tượng kết quả (✔ / ✘)
  List<Icon> scoreKeeper = [];
  int correctCount = 0;

  void checkAnswer(bool userPickedAnswer) {
    // So sánh câu trả lời của người dùng với đáp án đúng
    final bool isCorrect = quizBrain.getCorrectAnswer() == userPickedAnswer;
    if (isCorrect) correctCount++;

    final bool finished = quizBrain.isFinished();
    final int finalScore = correctCount;
    final int total = quizBrain.totalQuestions;

    setState(() {
      if (finished) {
        // Hết câu hỏi: đặt lại câu đầu tiên và xoá điểm cũ
        quizBrain.reset();
        scoreKeeper.clear();
        correctCount = 0;
      } else {
        scoreKeeper.add(
          isCorrect
              ? const Icon(Icons.check, color: Colors.green)
              : const Icon(Icons.close, color: Colors.red),
        );
        quizBrain.nextQuestion();
      }
    });

    if (finished) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hoàn thành!'),
          content: Text('Bạn trả lời đúng $finalScore/$total câu.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Chơi lại'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Câu hỏi
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),

        // Nút Đúng
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () => checkAnswer(true),
              child: const Text('Đúng', style: TextStyle(fontSize: 20)),
            ),
          ),
        ),

        // Nút Sai
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => checkAnswer(false),
              child: const Text('Sai', style: TextStyle(fontSize: 20)),
            ),
          ),
        ),

        // Hàng biểu tượng kết quả
        Row(children: scoreKeeper),
      ],
    );
  }
}