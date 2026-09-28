import 'package:flutter/material.dart';
import 'story_brain.dart';

void main() {
  runApp(const Destini());
}

class Destini extends StatelessWidget {
  const Destini({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const StoryPage(),
    );
  }
}

StoryBrain storyBrain = StoryBrain();

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  void chooseStory(int choice) {
    setState(() {
      if (!storyBrain.buttonShouldBeVisible()) {
        storyBrain.restart(); // đang ở đoạn kết -> bắt đầu lại
      } else {
        storyBrain.nextStory(choice);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: const Color.fromARGB(255, 22, 22, 22),
                    shape: const RoundedRectangleBorder(),
                  ),
                  onPressed: () => chooseStory(1),
                  child: Text(
                    storyBrain.getChoice1(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: storyBrain.buttonShouldBeVisible(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () => chooseStory(2),
                    child: Text(
                      storyBrain.getChoice2(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}