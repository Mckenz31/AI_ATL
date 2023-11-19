import 'package:flutter/material.dart';
import 'package:frontend/widgets/quiz_openended.dart';

class GenerateQuiz extends StatefulWidget {
  const GenerateQuiz({super.key});

  @override
  State<GenerateQuiz> createState() => _GenerateQuizState();
}

class _GenerateQuizState extends State<GenerateQuiz> {
  final TextEditingController mcq = TextEditingController();
  final TextEditingController trueFalse = TextEditingController();
  final TextEditingController shortAnswers = TextEditingController();

  void onSubmit() {
    if (mcq.text.trim().isEmpty ||
        trueFalse.text.trim().isEmpty ||
        shortAnswers.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Incomplete information'),
                content: const Text(
                    'Kindly enter a value in all of the fields'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Generate Quiz'))
                ],
              ));
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => QuizOpenEnded(mcqCount: mcq.text, trueFalseCount: trueFalse.text, shortAnswersCount: shortAnswers.text,))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Generate your own quiz',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: mcq,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText:
                    "Enter the number of MCQs you want your quiz to have",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: trueFalse,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText:
                    "Enter the number of True or False questions you want your quiz to have",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: shortAnswers,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter the number of Short answers",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      onSubmit();
                    },
                    child: const Text("Submit"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
