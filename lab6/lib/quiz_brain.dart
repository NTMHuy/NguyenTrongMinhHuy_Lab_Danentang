import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  // Danh sách câu hỏi (private: chỉ dùng trong file này)
  final List<Question> _questionBank = [
    Question(
        questionText: 'Flutter là framework do Google phát triển.',
        questionAnswer: true),
    Question(
        questionText: 'Ngôn ngữ lập trình chính của Flutter là Java.',
        questionAnswer: false),
    Question(
        questionText: 'StatelessWidget có thể thay đổi giao diện bằng setState().',
        questionAnswer: false),
    Question(
        questionText:
            'Hot reload cho phép xem thay đổi code mà không cần chạy lại toàn bộ ứng dụng.',
        questionAnswer: true),
    Question(
        questionText: 'Trong Flutter, hầu hết mọi thứ trên giao diện đều là widget.',
        questionAnswer: true),
    Question(
        questionText:
            'File pubspec.yaml dùng để khai báo dependencies và tài nguyên của dự án.',
        questionAnswer: true),
    Question(
        questionText: 'Column sắp xếp các widget con theo chiều ngang.',
        questionAnswer: false),
    Question(
        questionText:
            'Expanded giúp widget con chiếm phần không gian còn trống trong Row hoặc Column.',
        questionAnswer: true),
  ];

  int get totalQuestions => _questionBank.length;

  String getQuestionText() => _questionBank[_questionNumber].questionText;

  bool getCorrectAnswer() => _questionBank[_questionNumber].questionAnswer;

  // Chuyển sang câu tiếp theo (nếu còn)
  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  // Đã ở câu cuối chưa?
  bool isFinished() => _questionNumber >= _questionBank.length - 1;

  // Quay về câu đầu tiên
  void reset() {
    _questionNumber = 0;
  }
}