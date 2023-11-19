import 'package:flutter/material.dart';
import 'package:frontend/widgets/quiz_openended.dart';
import 'package:http/http.dart' as http;

class QuestionGenerator extends StatefulWidget {
  const QuestionGenerator({Key? key}) : super(key: key);

  @override
  _QuestionGeneratorState createState() => _QuestionGeneratorState();
}

class _QuestionGeneratorState extends State<QuestionGenerator> {
  int multipleChoiceCount = 0;
  int openEndedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Multiple Choice Questions',
              ),
              onChanged: (value) {
                setState(() {
                  multipleChoiceCount = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Open-ended Questions',
              ),
              onChanged: (value) {
                setState(() {
                  openEndedCount = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Use the generated counts as needed
                // For example, navigate to the FlashCards screen with the counts
                http.get(Uri.parse('127.0.0.1:61997/'));

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => QuizOpenEnded(
                //       multipleChoiceCount: multipleChoiceCount,
                //       openEndedCount: openEndedCount,
                //     ),
                //   ),
                // );
              },
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
