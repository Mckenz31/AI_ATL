import 'package:flutter/material.dart';
import 'package:frontend/widgets/summary_page.dart';
import 'package:numberpicker/numberpicker.dart';

class GenerateSummary extends StatefulWidget {
  const GenerateSummary({super.key});

  @override
  _GenerateSummaryState createState() => _GenerateSummaryState();
}

class _GenerateSummaryState extends State<GenerateSummary> {
  int _currentValue = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              "Select the percentage of time duration required for summay generation", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
          const SizedBox(
            height: 20,
          ),
          NumberPicker(
            value: _currentValue,
            minValue: 0,
            maxValue: 100,
            onChanged: (value) => setState(() => _currentValue = value),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Selected value: $_currentValue %', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red.shade50)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close', style: TextStyle(color: Colors.red),),
              ),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green.shade50)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SummaryPage(percentage: _currentValue,)));
                },
                child: const Text('Generate Summary', style: TextStyle(color: Colors.green),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
