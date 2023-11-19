import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizOpenEnded extends StatefulWidget {
  const QuizOpenEnded({
    Key? key,
    required this.mcqCount,
    required this.trueFalseCount,
    required this.shortAnswersCount,
  }) : super(key: key);

  final String mcqCount;
  final String trueFalseCount;
  final String shortAnswersCount;

  @override
  State<QuizOpenEnded> createState() => _QuizOpenEndedState();
}

class _QuizOpenEndedState extends State<QuizOpenEnded> {
  var questionIndex = 0;
  bool answered = false;
  var id = "A1B";
  final user_answer = TextEditingController();
  final TextEditingController _userAnswer = TextEditingController();
  bool? _answer;
  String? selectedValue;
  late List<dynamic> mcqData; // Store API response data
  late List<dynamic> openEndedData; // Store API response data

  @override
  void initState() {
    super.initState();
    mcqData = []; // Initialize with an empty list
    openEndedData = []; // Initialize with an empty list

    // Call the API request on page load
    _getMCQ();
    _getOpenEnded();
  }

  Future<void> _getMCQ() async {
    Map<String, String> payloadData = {
      'id': id,
      "mcq": widget.mcqCount,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/mcq'),
        body: jsonEncode(payloadData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          mcqData = data;
        });
        print('MCQ API Response: $data');
      } else {
        print('MCQ API Error: ${response.statusCode}');
      }
    } catch (error) {
      print('MCQ API Error: $error');
    }
  }

  Future<void> _getOpenEnded() async {
    Map<String, String> payloadData = {
      'id': id,
      "open": widget.shortAnswersCount,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/openEnded'),
        body: jsonEncode(payloadData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          openEndedData = data;
        });
        print('Open Ended API Response: $data');
      } else {
        print('Open Ended API Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Open Ended API Error: $error');
    }
  }

  void _handleAnswerChange(bool? value) {
    setState(() {
      _answer = value;
    });
  }

  Color getCardColor() {
    // Adjust this logic based on your actual data structure
    if (mcqData.isNotEmpty && mcqData[questionIndex%2] == "green") {
      return Colors.green.shade100;
    } else if (mcqData.isNotEmpty && mcqData[questionIndex%2] == "red") {
      return Colors.red.shade100;
    } else {
      return Colors.amber.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simpli Learn'),
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
                      // Adjust this logic based on your actual data structure
                        questionIndex < mcqData.length
                            ? mcqData[questionIndex][0]
                            : openEndedData[questionIndex-2],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                        // Adjust this logic based on your actual data structure
                        questionIndex < mcqData.length
                            ? mcqData[questionIndex][2]
                            : openEndedData[questionIndex-2],
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
                      questionIndex < mcqData.length + openEndedData.length - 1
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
    if (questionIndex < mcqData.length) {
      // Adjust this logic based on your actual data structure
      List<dynamic> options = mcqData[questionIndex][1];
      return Column(
        children: options.map((dynamic value) {
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
      // Adjust this logic based on your actual data structure
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

