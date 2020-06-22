import 'dart:core';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:geneexpert/base/ads_mana.dart';
import 'package:geneexpert/base/const.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/presenter.dart';
import 'package:geneexpert/base/utils.dart';
import 'package:geneexpert/page/hashtag/hashtag_page.dart';
import 'package:geneexpert/screen/favorite/favorite_view.dart';
import 'package:geneexpert/screen/setting/setting_page.dart';
import 'package:hive/hive.dart';
import 'views/time_view.dart';

class MorePresenter extends Presenter {
  static final String _rateKey = 'rating';
  final GlobalKey<TimeViewState> timerKey = GlobalKey();
  bool isRatting = false;
  static final String _yourClickKey = 'yourclickkey';
  static final String _timeDayKey = 'timedaykey';
  int yourClickSave = 0;

  // 1 lưu ngày đã click
  // 2 lưu số lần click
  // khi click để show ads thì kiểm tra số ngày click kia có phải ngày hôm này hay ko
  // 1: có: kiểm số lần click => yêu cầu Đc 5 lần (nếu đủ đk thì hiển thị)
  // 2: không => hiển thị luôn và lưu 2 thông số trên

  MorePresenter(BuildContext context, Contract view) : super(context, view);


  @override
  void init() async {
    super.init();
    RewardedVideoAd.instance
        .load(adUnitId: Const.reward, targetingInfo: AdsMana.targetingInfo);
    RewardedVideoAd.instance.listener =
        (event, {rewardType, rewardAmount}) async {
      if (event == RewardedVideoAdEvent.rewarded) {
       // quảng cáo đã chạy xong
      }
    };

    box = await Hive.openBox(_rateKey);
    bool rate = box.get(_rateKey);
    if(rate != null){
      isRatting = rate;
    }
    box ??= await Hive.openBox(_yourClickKey);
    bool yourClickSave = box.get(_yourClickKey);

    box ??= await Hive.openBox(_timeDayKey);
    DateTime timeDaySave = box.get(_timeDayKey);
    DateTime timeDaynow = DateTime.now();
    Duration duration = timeDaynow.difference(timeDaySave);
    int day = duration.inDays;
    if(day>0) {
    }

  }

  void _timeDayCheckin() async {
    box ??= await Hive.openBox(_timeDayKey);
    box.put(_timeDayKey, DateTime.now());
  }
  // 1 ngày chỉ đc hiển thị 5 lần thôi
  void showAds() {
    RewardedVideoAd.instance.show();
    _timeDayCheckin();  // lưu ngày user click lại
  }

  @override
  void loadData() async{
    super.loadData();
    box ??= await Hive.openBox(_rateKey);
    bool rate = box.get(_rateKey);
    if(rate != null){
      isRatting = rate;
      view.updateState();
    }
  }
  void onSetting() {
    Utils.navigator(context, SettingPage());
  }

  void onFavorites() {
    Utils.navigator(context, FavoritePage());
  }

  void checkin() {
    timerKey.currentState.startTimer();

//    String time =await TimeView().
//    onTime(time);
  }


  void onRatting() async {
    isRatting = true;
    box ??= await Hive.openBox(_rateKey);
    box.put(_rateKey, isRatting);
    debugPrint('Remove onRatting!');
    view.updateState();
  }
}
