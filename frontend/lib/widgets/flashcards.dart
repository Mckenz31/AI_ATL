import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:frontend/data/fake_data.dart';

class FlashCards extends StatefulWidget {
  const FlashCards({super.key});

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simpli Learn'),
      ),
      body: FlashCard(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        frontWidget: Container(child: Text('What is Dart?')),
        backWidget: Container(
          child: Text(
              'Dart is the programming language used to code Flutter apps. Its an object-oriented language developed by Google and used for various applications, including mobile app development.'),
        ),
      ),
    );
  }
}
