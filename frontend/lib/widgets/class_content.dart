import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/dashboard_model.dart';
import 'package:frontend/widgets/flashcards.dart';
import 'package:frontend/widgets/generate_quiz.dart';
import 'package:frontend/widgets/mini-pages/generate_summary.dart';
import 'package:frontend/widgets/quiz_openended.dart';
import 'package:frontend/widgets/chatbot.dart';
import 'package:frontend/widgets/summary_page.dart';

class ClassContent extends StatefulWidget {
  const ClassContent({super.key, required this.classData});

  final DashBoardItems classData;

  @override
  State<ClassContent> createState() => _ClassContentState();
}

class _ClassContentState extends State<ClassContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewind.io'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Text(
              '${widget.classData.date} - ${widget.classData.classTitle}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CardWidget(
                        assetImagePath: 'assets/images/summary.jpg',
                        text: 'Summary'),
                    CardWidget(
                      assetImagePath: 'assets/images/flashcards.jpg',
                      text: 'Flashcards',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CardWidget(
                        assetImagePath: 'assets/images/quiz.jpg',
                        text: 'Mockup quiz'),
                    CardWidget(
                        assetImagePath: 'assets/images/chatbot.jpg',
                        text: 'Chatbot'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CardWidget2(
                        assetImagePath: 'assets/images/exam-resized.jpg',
                        text: 'Graded quiz'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final String assetImagePath;
  final String text;

  CardWidget({required this.assetImagePath, required this.text});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.text == "Summary") {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: ((ctx) => const GenerateSummary()),
          );
        } 
        else if (widget.text == "Flashcards") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FlashCards()));
        } else if (widget.text == "Mockup quiz") {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: ((ctx) => const GenerateQuiz()),
          );
        } else if (widget.text == "Chatbot") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChatBotPage()));
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 150,
          height: 150,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  widget.assetImagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    widget.text,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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

class CardWidget2 extends StatelessWidget {
  final String assetImagePath;
  final String text;

  CardWidget2({required this.assetImagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const QuizOpenEnded(
                mcqCount: "10",
                trueFalseCount: "10",
                shortAnswersCount: "10")));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 200,
          height: 150,
          child: Column(
            children: [
              Expanded(
                flex: 3, // 3/5 of the space for the image
                child: Image.asset(
                  assetImagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2, // 2/5 of the space for the text
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
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

// void _showModal(BuildContext context) {
//   var slideValue = 0.5;

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Select summary duration'),
//         content: SingleChildScrollView(
//           child: Slider(
//               value: slideValue, label: '$slideValue', onChanged: (value) {
                
//               }),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Close'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Generate Quiz')),
//         ],
//       );
//     },
//   );
// }
