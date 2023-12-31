import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<ChatMessage> _messages = [];

  TextEditingController _messageController = TextEditingController();

  void _handleSubmitted(String text) async {
    _messageController.clear();

    // Simulate the bot's response (you can replace this logic with your own)

    Map<String, dynamic> payloadData = {
      'question': text,
    };
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/askChatbot'),
        body: jsonEncode(payloadData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _addMessage('StudyBot', response.body);
        print('Response: ${response.body}');
      } else {
        _addMessage('StudyBot',
            "I'm sorry, I failed to receive a response from the server.");
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    _addMessage('You', '$text');

    // You can add your own logic here to process the user's input and generate bot responses
  }

  void _addMessage(String sender, String text) {
    setState(() {
      _messages.add(ChatMessage(sender: sender, text: text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_messageController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String sender;
  final String text;

  ChatMessage({required this.sender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            child: Text(sender[0]),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sender,
              ),
              Text(
                  text,
                
              ),
              const Divider()
            ],
          ),
        ),
      ],
    );
  }
}

// class ChatMessage extends StatelessWidget {
//   final String sender;
//   final String text;

//   ChatMessage({required this.sender, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.only(right: 16.0),
//             child: CircleAvatar(
//               child: Text(sender[0]),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 sender,
//                 style: Theme.of(context).textTheme.subtitle1,
//               ),
//               Container(
//                   margin: const EdgeInsets.only(top: 5.0),
//                   child: Text(
//                     text,
//                     // Set maxLines and overflow properties to control text wrapping
//                     maxLines: 5, // Set to the desired maximum number of lines
//                     overflow: TextOverflow.ellipsis, // or TextOverflow.fade
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }