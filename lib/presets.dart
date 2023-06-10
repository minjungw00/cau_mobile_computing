import 'package:flutter/material.dart';

class PresetPage extends StatelessWidget {
  const PresetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('End'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
