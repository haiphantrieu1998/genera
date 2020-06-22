import 'package:flutter/material.dart';

class BannerButton extends StatelessWidget {
  final String dataButton;
  const BannerButton({Key key, this.dataButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          height: 25,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFC45CCB),
              Color(0xFF7D5FD3),
            ]),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            dataButton,
            style: TextStyle(fontSize: 14, fontWeight:FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
