import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SummaryPage extends StatefulWidget {

  const SummaryPage({super.key, required this.percentage});
  final int percentage;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
    late String summary;
    var id = "A1B";
    void initState() {
      super.initState();
      summary = ""; // Initialize with an empty list

      // Call the API request on page load
      _getSummary();
  }
  Future<void> _getAudio() async {
    Map<String, dynamic> payloadData = {
      'id': id,
      "summary": summary,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/downloadSpeech'),
        body: jsonEncode(payloadData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        
        
      } else {
        print('MCQ API Error: ${response.statusCode}');
      }
    } catch (error) {
      print('MCQ API Error: $error');
    }
  }
  Future<void> _getSummary() async {
    Map<String, dynamic> payloadData = {
      'id': id,
      "percentage": widget.percentage,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/getSummary'),
        body: jsonEncode(payloadData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          summary = data;
        });
        print('MCQ API Response: $data');
        _getAudio();
      } else {
        print('MCQ API Error: ${response.statusCode}');
      }
    } catch (error) {
      print('MCQ API Error: $error');
    }
  }
  // final Map<String, String> data = {
  //   "title1": "Technical competetions",
  //   "heading": "AI ATL was great",
  //   "bullet1": "An overview of the exciting opportunities at AI ATL.",
  //   "bullet2":
  //       "Insights into the creative projects developed during the event.",
  //   "bullet3": "A look at the networking and collaboration among participants.",
  //   "bullet4": "Highlights of the keynote speeches and workshops.",
  //   "bullet5": "The impact of AI ATL on local tech communities.",
  //   "bullet6": "Future prospects and upcoming events following AI ATL.",
  //   "bullet7": "An overview of the exciting opportunities at AI ATL.",
  //   "bullet8":
  //       "Insights into the creative projects developed during the event.",
  //   "bullet9": "A look at the networking and collaboration among participants.",
  //   "bullet10": "Highlights of the keynote speeches and workshops.",
  //   "bullet11": "The impact of AI ATL on local tech communities.",
  //   "bullet12": "Future prospects and upcoming events following AI ATL.",
  //   "heading2": "Hacking is fun?",
  //   "bullet13": "The impact of AI ATL on local tech communities.",
  //   "bullet14": "Future prospects and upcoming events following AI ATL.",
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Article Layout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: buildItem(summary),
      ),
    );
  }

  Widget buildItem(String summary) {
  return Container(
    // Add additional styling or constraints here
    child: Text(
      summary,
      style: TextStyle(fontSize: 16.0),  // Adjust the font size as needed
    ),
  );
  }
}
