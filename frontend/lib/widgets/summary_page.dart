import 'package:flutter/material.dart';
import 'package:frontend/widgets/flashcards.dart';

class SummaryPage extends StatelessWidget {
  final Map<String, String> data = {
    "title1": "Technical competetions",
    "heading": "AI ATL was great",
    "bullet1": "An overview of the exciting opportunities at AI ATL.",
    "bullet2":
        "Insights into the creative projects developed during the event.",
    "bullet3": "A look at the networking and collaboration among participants.",
    "bullet4": "Highlights of the keynote speeches and workshops.",
    "bullet5": "The impact of AI ATL on local tech communities.",
    "bullet6": "Future prospects and upcoming events following AI ATL.",
    "bullet7": "An overview of the exciting opportunities at AI ATL.",
    "bullet8":
        "Insights into the creative projects developed during the event.",
    "bullet9": "A look at the networking and collaboration among participants.",
    "bullet10": "Highlights of the keynote speeches and workshops.",
    "bullet11": "The impact of AI ATL on local tech communities.",
    "bullet12": "Future prospects and upcoming events following AI ATL.",
    "heading2": "Hacking is fun?",
    "bullet13": "The impact of AI ATL on local tech communities.",
    "bullet14": "Future prospects and upcoming events following AI ATL.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Article Layout'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.entries.map((entry) => buildItem(entry)).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlashCards()));
              },
              child: const Text(''),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(MapEntry<String, String> entry) {
    if (entry.key.startsWith('title')) {
      return Text(
        entry.value,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );
    } else if (entry.key.startsWith('heading')) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          entry.value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          '• ${entry.value}',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }
}
