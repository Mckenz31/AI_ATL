import 'package:flutter/material.dart';
import 'package:frontend/data/dashboard_model.dart';

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
                    CardWidget(assetImagePath: 'assets/images/summary.jpg', text: 'Summary'),
                    CardWidget(assetImagePath: 'assets/images/flashcards.jpg', text: 'Flashcards',),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CardWidget(assetImagePath: 'assets/images/quiz.jpg', text: 'Mockup quiz'),
                    CardWidget(assetImagePath: 'assets/images/chatbot.jpg', text: 'Chatbot'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CardWidget2(assetImagePath: 'assets/images/exam-resized.jpg', text: 'Graded quiz'),
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
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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