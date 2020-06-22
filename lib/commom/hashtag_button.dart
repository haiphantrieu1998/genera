import 'package:flutter/material.dart';
import 'package:geneexpert/themes/styles.dart';

class ButtonHashtag extends StatelessWidget {
  final String buttonText;
  const ButtonHashtag({Key key, this.buttonText}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(width: 2, color: GEXStyles.purple)),
        ),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              buttonText.toUpperCase(),
              style: TextStyle(
                color: GEXStyles.purple,
                // fontSize: 14.0,
                // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
