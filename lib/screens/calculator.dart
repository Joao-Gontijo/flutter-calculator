import 'package:calculator/components/display.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: [
          Display("123.45"),
          Text("Keyboard"),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}