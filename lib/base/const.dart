import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class Const {
  static const int TYPE_WEB = 0;
  static const int TYPE_EMAIL = 1;
  static const int TYPE_PHONE = 2;
  static const int TYPE_SMS = 3;
  static const String date_format = 'dd/MM/yyyy';
  static const String time_format = 'kk:mm:ss - dd/MM/yyyy';

  static const int CAMERA_PERMISSION = 1;
  static const int LOCATION_PERMISSION = 2;
  static const int PHOTOS_PERMISSION = 3;
  static const int MICROPHONE_PERMISSION = 4;
  static const int SPEECH_PERMISSION = 5;
  static const int LOCATION = 6;
  static const int LOCATION_ALAWAY = 7;

  static const String keySaveUser = 'keySaveUser';
  static const String appName = 'Schoolly';
  static const int limit = 40;
  static const String noMoreData = 'Đã hết dữ liệu';

  static const String noData = 'Không có dữ liệu';

  static const String googlePlaces = 'AIzaSyDx8cCMg6C8vXgLMCwQSU84jHf2qbEos9M';

  static const String error = 'Đã xảy ra lỗi';

  static const String inviting = 'inviting'; //là nó mời, mình chưa nhận

  static const String pending = 'pending'; // mình đã mời, nó chưa nhận

  static const String isfriend = 'is_friend'; // bạn bè

  static const String none = 'none'; // chưa là bạn bè
  // config loại timeline
  static const int TYPE_IMAGES = 1;
  static const int TYPE_NORMAL = 2;
  static const int TYPE_SHARE = 3;
  static final int minPw = 8;
  static final int maxPw = 32;
  static final int maxTimeResend = 120; // second
  static final String userBoxKey = 'userBoxKey';

  static const int EDIT_POST = 1;
  static const String LOGINBACK = 'TOKEN_ERROR';
  static const String POSTNOTFOUND = 'POST_NOT_FOUND';

  //notification
  static const int FRIEND_ACCEPTED = 1;
  static const int SEND_FRIEND_REQUEST = 2;
  static const int FRIEND_FOLLOWING = 3;
  static const int SOMEONE_FOLLOW_YOU = 4;
  static const int CHAT_MESSAGE = 5;
  static const int USER_COMMENT_POST = 6;
  static const int INVITE_ACCEPTED = 7;
  static const int LIKE_POST = 8;
  static const int LIKE_COMMENT = 9;
  static const int TAG_USER = 10;

  static final int minCtentLgth = 100;
  static final int maxCtentLgth = 100;

  static final int limitTag = 10;
  static const String LECTURE = 'LECTURE';

  static final int maxImagesTimelineCreate = 6;

//ROLE_STUDENT
//ROLE_TEACHER
//ROLE_PARENT
//ROLE_SYSTEM-ADMIN
//ROLE_ORG-ADMIN
//ROLE_USER
  static final String roleSTUDENT = 'ROLE_STUDENT';
  static final String roleUSER = 'ROLE_USER';
  static final String rolePARENT = 'ROLE_PARENT';
  static final String roleTEACHER = 'ROLE_TEACHER';
  static final String roleSYSTEMADMIN = 'ROLE_SYSTEM-ADMIN';
  static final String roleORGADMIN = 'ROLE_ORG-ADMIN';

  //Sex
  static final String sexFemale = 'FEMALE';
  static final String sexMale = 'MALE';

  //type dữ liệu
  static final String video = 'VIDEO';
  static final String article = 'ARTICLE';
  static final String image = 'IMAGE';
  static final String docs = 'DOCS';
  static final String choice = 'CHOICE';
  static final String essay = 'ESSAY';
  static final String course = 'COURSE';

  static final int maxDesCourseLession = 150;

  static final double ratioImage = 300 / 150;
  static final double ratioVideo = 16 / 9;

  static final String appId = Platform.isIOS
      ? 'ca-app-pub-4079807363593560~3748457290'
      : 'ca-app-pub-4079807363593560~4349779448';
  static final String banner = isDebug
      ? BannerAd.testAdUnitId
      : Platform.isAndroid
          ? 'ca-app-pub-4079807363593560/8097452769'
          : 'ca-app-pub-4079807363593560/6277104636';
  static final String interstitial = isDebug
      ? InterstitialAd.testAdUnitId
      : Platform.isAndroid
          ? 'ca-app-pub-4079807363593560/5471289429'
          : 'ca-app-pub-4079807363593560/4145765317';
  static final String reward = isDebug
      ? RewardedVideoAd.testAdUnitId
      : Platform.isIOS
          ? FirebaseAdMob.testAppId
          : 'ca-app-pub-4079807363593560/9974345489';
  static const bool isDebug = true;
}
