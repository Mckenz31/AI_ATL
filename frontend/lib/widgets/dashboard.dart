import 'package:flutter/material.dart';
import 'package:frontend/data/dashboard_model.dart';
import 'package:frontend/widgets/class_content.dart';
import 'package:frontend/widgets/file_upload.dart';
import 'package:frontend/widgets/hamburger.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, required this.course});

  final String course;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<DashBoardItems> itemList = [];
  List<DashBoardItems> items = [
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 17, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
    DashBoardItems(
        className: 'COSC3025',
        date: 'Nov 16, 2023',
        classTitle: 'Model making using HuggingFace',
        professor: 'Maria Politano'),
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 15, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 13, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
    DashBoardItems(
        className: 'COSC3025',
        date: 'Nov 14, 2023',
        classTitle: 'Model making using HuggingFace',
        professor: 'Maria Politano'),
        
    DashBoardItems(
        className: 'CS4050',
        date: 'Nov 16, 2023',
        classTitle: 'Advanced Networking',
        professor: 'Frank Poden'),
    DashBoardItems(
        className: 'CS4050',
        date: 'Nov 14, 2023',
        classTitle: 'Advanced Networking',
        professor: 'Frank Poden'),
        
    DashBoardItems(
        className: 'CS4050',
        date: 'Nov 13, 2023',
        classTitle: 'Advanced Networking',
        professor: 'Frank Poden'),
    DashBoardItems(
        className: 'COSC5340',
        date: 'Nov 10, 2023',
        classTitle: 'Generative AI incorporating Vertex AI',
        professor: 'Sundar Pitchai'),
  ];

  void selectItems(){
    for (var i = 0; i<items.length; i++){
      if(items[i].className == widget.course){
        itemList.add(items[i]);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewind.io'),
      ),
      drawer: const Hamburger(),
      body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/dashboard-bg.jpg"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassContent(classData: itemList[index],)));
            },
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: Text(itemList[index].className, style: const TextStyle(fontWeight: FontWeight.w700),),
                  title: Text(itemList[index].classTitle),
                  subtitle:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemList[index].professor), 
                        const SizedBox(height: 10,),
                        Text(itemList[index].date)
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
