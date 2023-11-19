import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/data/data.dart';

class FlashCards extends StatefulWidget {
  const FlashCards({super.key});

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {

  var questionIndex = 0;
  var id = "A1B";
  late ValueKey cardKey;
  late List<List<String>> flashCardData; // Store API response data

  @override
  void initState() {
    super.initState();
    cardKey = ValueKey(questionIndex);
    flashCardData = []; // Initialize with an empty list
    // Call the API request on page load
    _callApiRequest();
  }

  // Function to make the API request
  Future<void> _callApiRequest() async {
    Map<String, dynamic> payloadData = {
      'id': id,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/flashcards'),
        body: jsonEncode(payloadData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          flashCardData = (jsonDecode(response.body) as List)
              .map((item) => List<String>.from(item.map((dynamic e) => e.toString())))
              .toList();
        });
        print('API Response: $flashCardData');        // You can handle the API response here
      } else {
        print('API Error: ${response.statusCode}');
        // You can handle the API error here
      }
    } catch (error) {
      print('API Error: $error');
      // You can handle other errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewind.io'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 15,
            child: FlashCard(
              key: cardKey,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              frontWidget: Center(
                child: Text(
                  flashCardData.isNotEmpty
                      ? flashCardData[questionIndex][1] ?? ''
                      : 'Loading...',
                  style: const TextStyle(fontSize: 24,),
                  textAlign: TextAlign.center,
                ),
              ),              //Note that backcard is acting as a frontcard
              backWidget: Center(
                child: Text(
                  flashCardData.isNotEmpty
                      ? flashCardData[questionIndex][0] ?? ''
                      : 'Loading...',
                  style: const TextStyle(fontSize: 21),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              questionIndex > 0 ? 
              ElevatedButton(onPressed: (){
                setState(() {
                  questionIndex--;
                  cardKey = ValueKey(questionIndex);
                });
              }, child: const Icon(Icons.navigate_before),) : Container(),
              questionIndex < flashCardData.length - 1?
              ElevatedButton(onPressed: (){
                setState(() {
                  questionIndex++;
                  cardKey = ValueKey(questionIndex);
                });
              }, child: const Icon(Icons.navigate_next),) : Container(),
            ],
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}