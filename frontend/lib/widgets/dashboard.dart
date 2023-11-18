import 'package:flutter/material.dart';
import 'package:frontend/data/dashboard_model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<DashBoardItems> items = [
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 19, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
    DashBoardItems(
        className: 'COSC3025',
        date: 'Nov 17, 2023',
        classTitle: 'Model making using HuggingFace',
        professor: 'Maria Politano'),
        
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 19, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
    DashBoardItems(
        className: 'COSC3025',
        date: 'Nov 17, 2023',
        classTitle: 'Model making using HuggingFace',
        professor: 'Maria Politano'),
        
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 19, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
    DashBoardItems(
        className: 'COSC3025',
        date: 'Nov 17, 2023',
        classTitle: 'Model making using HuggingFace',
        professor: 'Maria Politano'),
        
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 19, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
    DashBoardItems(
        className: 'COSC3025',
        date: 'Nov 17, 2023',
        classTitle: 'Model making using HuggingFace',
        professor: 'Maria Politano'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpliLearn'),
      ),
      body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/xyz"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              // Handle the tap event
            },
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: Text(items[index].className),
                  title: Text(items[index].classTitle),
                  subtitle:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[index].professor), 
                        const SizedBox(height: 10,),
                        Text(items[index].date)
                      ],
                    )
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
