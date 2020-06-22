import 'package:flutter/material.dart';
import 'package:geneexpert/base/const.dart';
import 'package:geneexpert/themes/icons_ios.dart';
import 'package:geneexpert/themes/styles.dart';
import 'package:permission_handler/permission_handler.dart';

import 'row_step_permission.dart';

// enum Const { LOCATION, PHOTOS, CAMERA, LOCATION_ALAWAY, MICROPHONE, SPEED }

class GuidePermissionView extends StatelessWidget {
  final int typeGuide;

  GuidePermissionView({this.typeGuide});

  _closeGuide(context) {
    Navigator.pop(context);
  }

  _openSetting(context) {
    Navigator.pop(context);
    openAppSettings();
  }

  String _getText() {
    switch (typeGuide) {
      case Const.LOCATION:
      case Const.LOCATION_ALAWAY:
        return 'Location';
      case Const.PHOTOS_PERMISSION:
        return 'Photos';
      case Const.MICROPHONE_PERMISSION:
        return 'Microphone';
      case Const.SPEECH_PERMISSION:
        return 'Speech Recognition';
      default:
        return 'Camera';
    }
  }

  String _getIcon() {
    switch (typeGuide) {
      case Const.LOCATION_ALAWAY:
      case Const.LOCATION:
        return GEXIconIOS.iLocationPrivacy;
      case Const.PHOTOS_PERMISSION:
        return GEXIconIOS.iPhotosPrivacy;
      case Const.SPEECH_PERMISSION:
        return GEXIconIOS.icMicrophone;
      case Const.MICROPHONE_PERMISSION:
        return GEXIconIOS.icMicrophone;
      default:
        return GEXIconIOS.iCameraPrivacy;
    }
  }

  String _getTitle() {
    switch (typeGuide) {
      case Const.LOCATION_ALAWAY:
        return '${Const.appName} cần quyền vị trí luôn luôn để hoạt động với tính năng thông báo camera phạt nguội chạy nền';
      default:
        return '${Const.appName} không có quyền truy cập vào "${_getText()}". Bật tính năng này để sử dụng ${_getText()}';
    }
  }

  String _getTitleEnd() {
    switch (typeGuide) {
      case Const.LOCATION_ALAWAY:
        return '4. Chọn luôn luôn';
      default:
        return '4. Cho phép ứng dụng sử dụng "${_getText()}"';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0), // here the desired height
            child: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black.withOpacity(0.85),
                brightness: Brightness.dark)),
        backgroundColor: Colors.black.withOpacity(0.85),
        body: Container(
            child: Column(children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: () => _closeGuide(context),
                  child: Text('Đóng',
                      style: GEXStyles.copyStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)))),
          Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(_getTitle(),
                  textAlign: TextAlign.center,
                  style: GEXStyles.copyStyle(fontSize: 16, color: Colors.white))),
          RowStep(icon: GEXIconIOS.iSetting, title: '1. Mở ứng dụng cài đặt'),
          RowStep(icon: GEXIconIOS.iPrivacy, title: '2. Chọn riêng tư'),
          RowStep(icon: _getIcon(), title: '3. Chọn "${_getText()}"'),
          RowStep(icon: GEXIconIOS.iSwitch, title: _getTitleEnd()),
          FlatButton(
              onPressed: () => _openSetting(context),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Text('Cho phép truy cập',
                    style: GEXStyles.copyStyle(fontSize: 16, color: Colors.white)),
              )),
        ])));
  }
}
