import 'package:lab7_destini/story.dart';

class StoryBrain {
  static const int notChooseIndex = -1; // Chỉ mục không hợp lệ
  int _currentIndex = 0;
  final List<int> _history = [];  // Stack lưu lại các chỉ mục đã chọn

  final List<Story> _stories = [
    Story(
      storyText:
          'Bạn đứng trước một ngã rẽ trong rừng, một con đường dẫn vào bóng tối, một con đường sáng hơn. Bạn sẽ đi đâu?',
      choices: [
        Choice(choiceText: 'Đi vào bóng tối', nextIndex: 1),
        Choice(choiceText: 'Đi vào con đường sáng', nextIndex: 2),
      ],
    ),
    Story(
      storyText:
          'Con đường tối tăm khiến bạn cảm thấy lạnh lẽo. Bỗng nhiên, bạn nghe thấy tiếng động lạ.',
      choices: [
        Choice(choiceText: 'Đi về phía tiếng động', nextIndex: 3),
        Choice(choiceText: 'Bỏ đi và tiếp tục đi', nextIndex: 4),
      ],
    ),
    Story(
      storyText:
          'Bạn đã đến một ngôi nhà hoang. Cửa chính đóng kín, nhưng có một cửa sổ mở ra phía bên trái.',
      choices: [
        Choice(choiceText: 'Vào qua cửa sổ', nextIndex: 5),
        Choice(choiceText: 'Gõ cửa', nextIndex: 6),
      ],
    ),
    Story(
      storyText:
          'Một con quái vật xuất hiện! Bạn chiến đấu với nó hay bỏ chạy?',
      choices: [
        Choice(choiceText: 'Chiến đấu', nextIndex: 7),
        Choice(choiceText: 'Bỏ chạy', nextIndex: 8),
      ],
    ),
    Story(
      storyText:
          'Bạn đến một thành phố, nơi mọi người đều mỉm cười với bạn. Bạn có cảm giác không an toàn.',
      choices: [
        Choice(choiceText: 'Khám phá thành phố', nextIndex: 9),
        Choice(choiceText: 'Rời đi ngay', nextIndex: 10),
      ],
    ),
    Story(
      storyText:
          'Bạn quyết định trở về. Con đường về vẫn đầy bóng tối và bạn cảm thấy lo sợ.',
      choices: [
        Choice(choiceText: 'Chạy nhanh về phía trước', nextIndex: 11),
        Choice(choiceText: 'Dừng lại nghỉ ngơi', nextIndex: 12),
      ],
    ),
    Story(
      storyText:
          'Bạn vào trong ngôi nhà. Một bóng đen xuất hiện và tấn công bạn.',
      choices: [
        Choice(choiceText: 'Đánh lại bóng đen', nextIndex: 13),
        Choice(choiceText: 'Trốn trong phòng', nextIndex: 14),
      ],
    ),
    Story(
      storyText:
          'Bạn chiến đấu và giành chiến thắng. Tuy nhiên, bạn bị thương và không thể tiếp tục.',
      choices: [
        Choice(choiceText: 'Kết thúc', nextIndex: 15),
        Choice(choiceText: 'Điều trị vết thương', nextIndex: 15),
      ],
    ),
    Story(
      storyText:
          'Con quái vật bỏ đi. Bạn tiếp tục hành trình mà không bị tổn hại.',
      choices: [
        Choice(choiceText: 'Đi tiếp', nextIndex: 5),
        Choice(choiceText: 'Dừng lại nghỉ ngơi', nextIndex: 6),
      ],
    ),
    Story(
      storyText:
          'Bạn rời thành phố và tìm thấy một con đường khác, nhưng bạn bị lạc.',
      choices: [
        Choice(choiceText: 'Đi tiếp', nextIndex: 10),
        Choice(choiceText: 'Tìm đường quay lại', nextIndex: 11),
      ],
    ),
    Story(
      storyText:
          'Bạn tiếp tục khám phá thành phố và tìm thấy một cửa hàng kỳ lạ.',
      choices: [
        Choice(choiceText: 'Vào cửa hàng', nextIndex: 12),
        Choice(choiceText: 'Ra ngoài ngay', nextIndex: 13),
      ],
    ),
    Story(
      storyText:
          'Cảnh vật xung quanh thay đổi và bạn thấy một khu rừng khác. Bạn có cảm giác mình đang lạc vào một thế giới khác.',
      choices: [
        Choice(choiceText: 'Khám phá khu rừng', nextIndex: 14),
        Choice(choiceText: 'Quay lại', nextIndex: 15),
      ],
    ),
    Story(
      storyText:
          'Cửa sổ của ngôi nhà có một người lạ nhìn bạn. Họ mời bạn vào trong.',
      choices: [
        Choice(choiceText: 'Vào nhà', nextIndex: 5),
        Choice(choiceText: 'Bỏ đi', nextIndex: 6),
      ],
    ),
    Story(
      storyText: 'Cuối cùng bạn đã đến nơi an toàn. Kết thúc hành trình.',
      choices: [], // Kết thúc
    ),
    Story(
      storyText: 'Bạn tiếp tục chạy. Cuối cùng bạn bị lạc trong bóng tối.',
      choices: [], // Kết thúc
    ),
    // Story 15 - New ending
    Story(
      storyText:
          'Bạn đã hoàn thành hành trình của mình với những quyết định sáng suốt. Chúc mừng bạn!',
      choices: [], // Kết thúc
    ),
  ];

  Story get currentStory {
    // Kiểm tra nếu currentIndex là notChooseIndex, nếu có thì hiển thị câu chuyện đặc biệt
    if (_currentIndex == notChooseIndex) {
      return Story(
        storyText: "Câu chuyện đã kết thúc hoặc không có lựa chọn hợp lệ.",
        choices: [], // Không có lựa chọn
      );
    }
    return _stories[_currentIndex];
  }

  bool get isEnd =>
      (_currentIndex < 0) ||
      (_currentIndex >= _stories.length - 1) ||
      _stories[_currentIndex].choices.isEmpty;

  // Kiểm tra lựa chọn hợp lệ trước khi cập nhật chỉ mục

  void choose(int choiceNumber) {
    assert(0 <= choiceNumber && choiceNumber < currentStory.choices.length);

    final nextIndex = currentStory.choices[choiceNumber].nextIndex;

    if (nextIndex != notChooseIndex && nextIndex < _stories.length) {
      _history.add(_currentIndex);
      _currentIndex = nextIndex;
    } else {
      print("End of story or no valid next choice.");
      _currentIndex = notChooseIndex;
    }
  }

  void undo() {
    if (_history.isNotEmpty) {
      _currentIndex = _history.removeLast();  // Quay lại trạng thái trước đó
    }
  }

  void restart() {
    _currentIndex = 0;
  }
}
/*
thiết kế lại dữ liệu cốt truyện để đảm bảo chính xác. hãy in ra các story, index của chúng, các choices dẫn tới các story tiếp theo. 
Yêu cầu:
- Bắt đầu tại Story 0
- Mọi story đều có thể tới được từ story 0
- không có nextIndex nào >= stories.length
- Cốt truyện hợp lý, khép kín.

Thiết kế chính xác 16 story không hơn không kém trong đó có 2 ending story.. 

Hãy kiểm tra thật kĩ bằng cách tự đọc lại code và in ra dưới dạng plaintext 
- Story 0: choice 1: story 2. choice 2: story 3 ...
- Story 1: ...
- ...
- Story 14: Ending
- Story 15: Ending (no choice)
*/