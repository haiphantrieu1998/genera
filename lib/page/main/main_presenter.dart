import 'package:flutter/material.dart';
import 'package:geneexpert/page/banner/banner_page.dart';
import 'package:geneexpert/page/generator/generator_page.dart';
import 'package:geneexpert/page/hashtag/hashtag_page.dart';

import '../../base/contract.dart';
import '../../base/presenter.dart';

class MainPresenter extends Presenter {
  int bottomSelectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  GlobalKey<GeneratorPageState> keyGenerator = GlobalKey();
  GlobalKey<HashtagPageState> keyHashTag = GlobalKey();
  GlobalKey<BannerPageState> keyBanner = GlobalKey();

  MainPresenter(BuildContext context, Contract view) : super(context, view);

  @override
  void init() async {
    super.init();
  }

  void bottomTapped(int value) async {
    if (value == bottomSelectedIndex) {
      if (value == 0)
        keyGenerator.currentState.scrollToTop();
      else if (value == 1)
        keyHashTag.currentState.scrollToTop();
      else if (value == 2) keyBanner.currentState.scrollToTop();
    } else {
      bottomSelectedIndex = value;
      pageController.jumpToPage(
        value,
      );
      view.updateState();
    }
  }

  void pageChanged(int value) {
    // bottomSelectedIndex = value;
    // _view.updateState();
  }
}
