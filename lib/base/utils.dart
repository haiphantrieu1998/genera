import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geneexpert/views/guide_permission_view.dart';
import 'package:permission_handler/permission_handler.dart';

import 'const.dart';

class Utils {
  static void showToast(String title, {bool isLong: false}) {
    if (title != null)
      Fluttertoast.showToast(
        msg: title,
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black.withOpacity(0.5),
        textColor: Colors.white,
      );
  }

  static Future navigator(BuildContext context, Widget view) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => view));
  }

  static Future navigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static void _askPermission(
      {BuildContext context, Function handle, int type}) {
    Permission permission;
    if (type == Const.LOCATION_PERMISSION) {
      permission = Permission.location;
    } else if (type == Const.PHOTOS_PERMISSION) {
      permission = Permission.photos;
    } else if (type == Const.CAMERA_PERMISSION) {
      permission = Permission.camera;
    } else if (type == Const.MICROPHONE_PERMISSION) {
      permission = Permission.microphone;
    } else if (type == Const.SPEECH_PERMISSION) {
      permission = Permission.speech;
    }

    if (Platform.isAndroid) {
      permission.status.then((value) {
        if (value == PermissionStatus.denied) {
          permission.request().then((value2) {
            if (value == PermissionStatus.granted) {
              handle();
            }
          });
        } else if (value == PermissionStatus.granted) {
          handle();
        }
      });
    } else if (Platform.isIOS) {
      permission.status.then((value) {
        if (value == PermissionStatus.undetermined) {
          //first request
          permission.request().then((value) {
            if (value == PermissionStatus.granted) {
              handle();
            }
          });
        } else if (value == PermissionStatus.denied ||
            value == PermissionStatus.restricted
        // || value == PermissionStatus.disabled
        ) {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  GuidePermissionView(typeGuide: type)));
        } else {
          handle();
        }
      });
    }
  }

  static void askPermissionGPS(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, type: Const.LOCATION_PERMISSION);
  }

  static void askPermissionPhotos(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, type: Const.PHOTOS_PERMISSION);
  }

  static void askPermissionCamera(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, type: Const.CAMERA_PERMISSION);
  }

  static void askPermissionSpeech(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, type: Const.SPEECH_PERMISSION);
  }
}
