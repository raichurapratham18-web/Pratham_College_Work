import 'package:flutter/material.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({super.key});

  @override
  State<CalendarExample> createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  DateTime? data;
  Future<void> pickData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: data ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (!mounted || picked == null) return;
    setState(() => data = picked);
  }

  void SetDateValue(){
    setState(() {
      data = DateTime(2023, 1, 1);
    });
  }
  @override
  Widget build(BuildContext context) {
    final text = 
    data == null ? 'No date selected' : "${data!.day}/${data!.month}/${data!.year}";
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(
              onPressed: pickData,
              child: const Text('Pick a date'),
            ),
            ElevatedButton(
              onPressed: SetDateValue,
              child: const Text('Set Date to 01/01/2023'),
            ),
          ],
        ),
      ),
    );
  }
}