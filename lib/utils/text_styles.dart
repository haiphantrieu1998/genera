import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();
  static final TextStyle textLeadingTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.yellow[900],
  );
  static final TextStyle subscriptionTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle subscriptionAmountTextStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
}
