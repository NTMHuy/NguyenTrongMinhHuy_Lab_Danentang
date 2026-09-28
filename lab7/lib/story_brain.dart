import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    // 0
    Story(
      storyTitle:
          'Xe của bạn bị nổ lốp giữa đường vắng. Bạn vẫy xe và một người đàn ông lạ mặt dừng lại. Ông ta hỏi bạn có cần giúp không.',
      choice1: 'Tôi sẽ lên xe ông ấy',
      choice2: 'Tôi sẽ tự thay lốp',
    ),
    // 1
    Story(
      storyTitle:
          'Ông ta hỏi bạn thích nhạc gì. Bạn sẽ trả lời thế nào?',
      choice1: 'Tôi thích nhạc rock',
      choice2: 'Tôi thích nhạc cổ điển',
    ),
    // 2
    Story(
      storyTitle:
          'Bạn tự thay lốp xong xuôi và tiếp tục hành trình an toàn.',
      choice1: 'Bắt đầu lại',
      choice2: '',
    ),
    // 3
    Story(
      storyTitle:
          'Ông ta bật nhạc rock thật lớn và chở bạn đến thị trấn an toàn.',
      choice1: 'Bắt đầu lại',
      choice2: '',
    ),
    // 4
    Story(
      storyTitle:
          'Ông ta im lặng rồi tấp xe vào lề. Chuyến đi kết thúc bất ngờ.',
      choice1: 'Bắt đầu lại',
      choice2: '',
    ),
  ];

  // Chỉ số đoạn tiếp theo tương ứng với từng đoạn ở _storyData
  final List<List<int>> _nextStory = [
    [1, 2], // đoạn 0
    [3, 4], // đoạn 1
    [0, 0], // đoạn 2 (kết thúc)
    [0, 0], // đoạn 3 (kết thúc)
    [0, 0], // đoạn 4 (kết thúc)
  ];

  String getStory() => _storyData[_storyNumber].storyTitle;

  String getChoice1() => _storyData[_storyNumber].choice1;

  String getChoice2() => _storyData[_storyNumber].choice2;

  void nextStory(int choiceNumber) {
    _storyNumber = _nextStory[_storyNumber][choiceNumber - 1];
  }

  void restart() {
    _storyNumber = 0;
  }

  // Nút 2 chỉ hiện khi còn đủ 2 lựa chọn (chưa đến đoạn kết)
  bool buttonShouldBeVisible() {
    return _storyData[_storyNumber].choice2.isNotEmpty;
  }
}