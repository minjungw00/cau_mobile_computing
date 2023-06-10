import 'package:flutter/material.dart';

class StretchPage extends StatelessWidget {
  const StretchPage({Key? key}) : super(key: key);

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
