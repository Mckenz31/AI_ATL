import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:frontend/data/fake_data.dart';

class FlashCards extends StatefulWidget {
  const FlashCards({super.key});

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {

  var questionIndex = 0;
  late ValueKey cardKey;

  @override
  void initState() {
    super.initState();
    cardKey = ValueKey(questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simpli Learn'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 15,
            child: FlashCard(
              key: cardKey,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              frontWidget: Center(child: Text(FakeData().questions.values.elementAt(questionIndex), style: const TextStyle(fontSize: 24,), textAlign: TextAlign.center,)),
              //Note that backcard is acting as a frontcard
              backWidget: Center(
                child: Text(
                  FakeData().questions.keys.elementAt(questionIndex),
                    style: const TextStyle(fontSize: 21),
                    textAlign: TextAlign.center,),
                    
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
              questionIndex < FakeData().questions.length - 1?
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
