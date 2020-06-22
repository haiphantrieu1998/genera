import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'const.dart';


class AdsMana {
  static AdsMana getInstance() {
    _instance ??= AdsMana();
    return _instance;
  }

  static BannerAd _bannerAd;
  static InterstitialAd _interstitialAd;
  static double rootHeighAds = 0;
  static AdsMana _instance;

  static MobileAdTargetingInfo targetingInfo = const MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[
      // "2536C285A448AC2C8D0A0C392C5B936A"
    ], // Android emulators are considered test devices
  );

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: Const.banner,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        // print("BannerAd event $event");
        if (event == MobileAdEvent.loaded) {}
      },
    );
  }

  static InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: Const.interstitial,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  void init() {
    _bannerAd = createBannerAd()..load();
  }

  Future showAdsFull() async {
    try {
      await _interstitialAd?.dispose();
    } catch (e) {}
    _interstitialAd = null;
    _interstitialAd = createInterstitialAd();
    await _interstitialAd?.load();
    _interstitialAd?.show();
  }

  void showAdsBanner(bool isRoot, {double height}) async {
    print('height => $height');
    print('isRoot => $isRoot');
    try {
      await _bannerAd?.dispose();
    } catch (e) {}
    _bannerAd = null;
    _bannerAd ??= createBannerAd();
    await _bannerAd.load();
    _bannerAd.show(
        anchorOffset: height ?? (isRoot ? kBottomNavigationBarHeight : 0),
        anchorType: AnchorType.top);
  }

  Future hideBanner() async {
    await _bannerAd?.dispose();
    _bannerAd = null;
  }
}
