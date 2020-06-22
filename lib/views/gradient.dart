import 'package:flutter/material.dart';

class Gradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xffC45CCB),
        Color(0xff7D5FD3),
      ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
    );
  }
}
