import 'package:flutter/material.dart';
import 'package:frontend/data/dashboard_model.dart';
import 'package:frontend/widgets/generate_quiz.dart';
import 'package:frontend/widgets/quiz_openended.dart';

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
        title: const Text('SimpliLearn'),
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

class CardWidget extends StatelessWidget {
  final String assetImagePath;
  final String text;

  CardWidget({required this.assetImagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == "Mockup quiz") {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: ((ctx) => const GenerateQuiz()),
          );
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
  
//   final TextEditingController mcq = TextEditingController();
//   final TextEditingController true_false = TextEditingController();
//   final TextEditingController short_answers = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Generate your own quiz'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Enter the number of questions you want for:'),
//               TextField(
//                 controller: mcq,
//                 maxLength: 2,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: "MCQs",
//                 ),
//               ),
//             ],
//           ),
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