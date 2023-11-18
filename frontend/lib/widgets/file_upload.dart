import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/widgets/summary_page.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  var slideValue = 0.5;
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File picker demo"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            child: const Icon(Icons.upload, size: 120,),
            // color: Colors.amber,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (result != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Selected file:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: result?.files.length ?? 0,
                          itemBuilder: (context, index) {
                            return Text(result?.files[index].name ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);
                      if (result == null) {
                        print("No file selected");
                      } else {
                        setState(() {});
                        for (var element in result!.files) {
                          print(element.name);
                        }
                      }
                    },
                    child: const Text("File Picker"),
                  ),
                ),
                const SizedBox(height: 20,),
                Slider(
                    value: slideValue,
                    label: '$slideValue',
                    onChanged: (value) {
                      setState(
                        () {
                          slideValue = value;
                        },
                      );
                    }),
                Text('${((slideValue * 100).toInt())}%'),
                const SizedBox(height: 40,), 
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) =>  SummaryPage()));
                    }, child: const Text('Generate summary'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
