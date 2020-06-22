import 'package:flutter/material.dart';

class GEXStyles {
  static final String font = 'Ubuntu';
  static final double sizeFont = 14;

  static TextStyle copyStyle(
          {Color color,
          FontWeight fontWeight = FontWeight.normal,
          double fontSize,
          TextDecoration decoration,
          FontStyle fontStyle}) =>
      TextStyle(
          fontSize: fontSize ?? sizeFont,
          color: color ?? colorTv1,
          fontWeight: fontWeight,
          decoration: decoration ?? TextDecoration.none,
          fontFamily: font,
          fontStyle: fontStyle);

  static TextStyle appBar({Color color}) => copyStyle(
      fontSize: 18, color: color ?? colorTv1, fontWeight: FontWeight.normal);

  static TextStyle appBarPage() => copyStyle(
      color: GEXStyles.colorPrimary1,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  // login , register, forgotpw, change pw
  static TextStyle title() =>
      copyStyle(color: blackLight.withOpacity(0.5), fontSize: 12);

  static TextStyle hint() => copyStyle(color: blackLight.withOpacity(0.3));

  static TextStyle textField() => copyStyle();

  static TextStyle error() => copyStyle(color: Colors.red, fontSize: 10);

  static TextStyle forgot() =>
      copyStyle(decoration: TextDecoration.underline, color: colorPrimary2);

  static TextStyle btn() =>
      copyStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13);

  static TextStyle normal() => copyStyle(color: colorTv1);

  static TextStyle link() => copyStyle(color: colorPrimary4);

//Color
  static final Color yellow1 = Color(0xffFFC107);
  static final LinearGradient gradient = LinearGradient(
      colors: [Color(0xffC45CCB),
       Color(0xff7D5FD3)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);


  static final Color gradienStart = Color(0xffC45CCB);
  static final Color gradienEnd = Color(0xff7D5FD3);
  static final Color mainColor = Color(0xff5C3A7B);
  static final Color purple = Color(0xffBE61CF);
  static final Color purple3 = Color(0xffF2F3FC);
  static final Color tvgray = Color(0xff626262);
  static final Color bg = Color(0xffF2F3F5);

  // primay color
  static final Color colorPrimary1 = Color(0xff6FDA44);
  static final Color colorPrimary2 = Color(0xff37A000);
  static final Color colorPrimay3 = Color(0xff008329);
  static final String colorPrimary2Str = '#37A000';
  static final Color colorPrimary4 = Color(0xff1481FE);

  // text
  static final Color colorTv1 = Color(0xff222222);
  static final Color colorTv2 = Color(0xff656565);
  static final Color colorTv3 = Color(0xffE0E0E0);
  static final Color colorTv4 = Color(0xffF2F2F2);
  static final Color colorTv5 = Color(0xffF9F9F9);

  //neutral colors
  static final Color colorNeutral1 = Color(0xffEBF7EC);
  static final Color colorNeutral2 = Color(0xff008329);
  static final Color colorNeutral3 = Color(0xff008EAF);
  static final Color colorNeutral4 = Color(0xff1D4354);
  static final Color colorNeutral5 = Color(0xff2579E7);
  static final Color colorNeutral6 = Color(0xffE6A01E);
  static final Color colorNeutral7 = Color(0xffD50000);
  static final Color colorNeutral8 = Color(0xffCDC52D);
  static final Color colorNeutral9 = Color(0xff2B5468);
  static final Color colorNeutral10 = Color(0xffE0E0E0);
  static final Color colorNeutral11 = Colors.white;

  static final Color blueBg = Color(0xff5A96FF);
  static final Color blueMain = Color(0xff5C48C5);
  static final Color yellowBg = Color(0xffFFCA56);
  static final Color pinkBg = Color(0xffEF72C4);
  static final Color purpleBg = Color(0xffA671FE);
  static final Color grey = Color(0xffEEEEEE);
  static final Color grey12 = Color(0xffA6A5A5);
  static final Color white = Color(0xffFFFFFF);

  static final Color greyLight = Color(0xffECEBEB);
//  static final Color bg = Color(0xffFBFCFE);
  static final Color bg2 = Color(0xffFBFBFB);
  static final Color bg3 = Color(0xffF2F2F2);
  static final Color yellow = Color(0xffF2C94C);

  static final Color black2 = Color(0xff666666);
  static final Color black3 = Color(0xff999999);
  static final Color black4 = Color(0xffCCCCCC);

  static final Color blackIcon = Color(0xff1F2D3D);
  static final Color black12 = Color(0xffF8F8F8);
  static final Color black80 = Color(0xff12192B);
  static final Color blackLight = Color(0xff161F3D);

  static final Color bgline = Color(0xff1D1D26);
  static final Color shadow = Color(0xff686868);
}
