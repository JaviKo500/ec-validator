import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EC Validator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ec Validator'),
        ),
        body: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('0105566046'),
                Text('Is valid?: '),
              ],
            ),
          ],
        )
      ),
    );
  }
}