import 'package:flutter/material.dart';

import 'package:ec_validator/shared/bottom_navigator_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EC Validator',
      debugShowCheckedModeBanner: false,
      home: CustomBottomNavigatorBar(),
    );
  }
}