import 'package:flutter/material.dart';
import 'package:frontend/data/data.dart';

class QuizOpenEnded extends StatefulWidget {
  const QuizOpenEnded({super.key});

  @override
  State<QuizOpenEnded> createState() => _QuizOpenEndedState();
}

class _QuizOpenEndedState extends State<QuizOpenEnded> {
  var questionIndex = 0;
  bool answered = false;
  final user_answer = TextEditingController();
  final TextEditingController _userAnswer = TextEditingController();
  bool? _answer;
  String? selectedValue;

  void _handleAnswerChange(bool? value) {
    setState(() {
      _answer = value;
    });
  }

  Color getCardColor() {
    if (FakeData().solutionCheck.keys.elementAt(questionIndex) == "green") {
      return Colors.green.shade100;
    } else if (FakeData().solutionCheck.keys.elementAt(questionIndex) ==
        "red") {
      return Colors.red.shade100;
    } else {
      return Colors.amber.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simli Learn'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Question No: ${questionIndex + 1}'),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      FakeData().questions.keys.elementAt(questionIndex),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    answerType(),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          answered = true;
                        });
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            answered
                ? Card(
                    color: getCardColor(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        FakeData()
                            .solutionCheck
                            .values
                            .elementAt(questionIndex),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                : Container(),
            const Spacer(),
            answered
                ? Row(
                    children: [
                      questionIndex > 0
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  questionIndex--;
                                  answered = false;
                                });
                              },
                              child: const Icon(Icons.navigate_before),
                            )
                          : Container(),
                      const Spacer(),
                      questionIndex < FakeData().solutionCheck.length - 1
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  questionIndex++;
                                  answered = false;
                                });
                              },
                              child: const Icon(Icons.navigate_next),
                            )
                          : Container(),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget answerType() {
    if (FakeData().questions.values.elementAt(questionIndex) == "true" ||
        FakeData().questions.values.elementAt(questionIndex) == "false") {
      return Column(
        children: [
          ListTile(
            title: const Text('True'),
            leading: Radio<bool>(
              value: true,
              groupValue: _answer,
              onChanged: _handleAnswerChange,
            ),
          ),
          ListTile(
            title: const Text('False'),
            leading: Radio<bool>(
              value: false,
              groupValue: _answer,
              onChanged: _handleAnswerChange,
            ),
          ),
        ],
      );
    }
    else if (FakeData()
            .questions
            .values
            .elementAt(questionIndex)
            .split(',')
            .where((word) => word.isNotEmpty)
            .length >
        2) {
      List<String> words = FakeData()
          .questions
          .values
          .elementAt(questionIndex)
          .split(', ')
          .where((word) => word.isNotEmpty)
          .toList();
      return Column(
        children: words.map((String value) {
          return ListTile(
            title: Text(value),
            leading: Radio<String>(
              value: value,
              groupValue: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue;
                });
              },
            ),
          );
        }).toList(),
      );
    } else {
      return TextField(
        controller: user_answer,
        maxLines: 5,
        decoration: const InputDecoration(
          label: Text("Enter your answer"),
        ),
      );
    }
  }
}
