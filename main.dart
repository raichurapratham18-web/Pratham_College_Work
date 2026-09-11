import 'package:flutter/material.dart';
import 'dropdown.dart';
void main() {
  runApp(const StopwatchRun());
}

class StopwatchRun extends StatelessWidget {
  const StopwatchRun({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DropDownExample(),
    );
  }
}