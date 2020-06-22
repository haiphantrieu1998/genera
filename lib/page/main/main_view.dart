import 'package:flutter/material.dart';
import 'package:geneexpert/page/banner/banner_page.dart';
import 'package:geneexpert/page/generator/generator_page.dart';
import 'package:geneexpert/page/hashtag/hashtag_page.dart';
import 'package:geneexpert/page/more/more_page.dart';
import 'package:geneexpert/themes/styles.dart';
import 'dart:ui' as ui;
import '../../base/contract.dart';
import 'main_presenter.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => MainStateView();
}

class MainStateView extends State<MainView> implements Contract {
  MainPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = MainPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _presenter.bottomSelectedIndex,
        onTap: _presenter.bottomTapped,
        selectedItemColor: GEXStyles.gradienEnd,
        unselectedItemColor: GEXStyles.colorTv2,
        selectedLabelStyle: GEXStyles.copyStyle(color: GEXStyles.mainColor),
        unselectedLabelStyle: GEXStyles.copyStyle(color: GEXStyles.colorTv2),
        items: buildBottomNavBarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      _btNBItem('assets/icons/ic_generator.png', 'Generator'),
      _btNBItem('assets/icons/ic_hashtag.png', 'Hashtag'),
      _btNBItem('assets/icons/ic_banner.png', 'Banner'),
      _btNBItem('assets/icons/ic_more.png', 'More'),
    ];
  }

  BottomNavigationBarItem _btNBItem(String icon, String text) {
    double size = 22;
    return BottomNavigationBarItem(
        icon: Image(
          image: AssetImage(icon),
          width: size,
          height: size,
          color: GEXStyles.colorTv2,
        ),
        activeIcon: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return ui.Gradient.linear(
              Offset(0, 0),
              Offset(32, 32),
              [
                GEXStyles.gradienStart,
                GEXStyles.gradienEnd,
              ],
            );
          },
          child: Image(
            image: AssetImage(icon),
            width: size,
            height: size,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            text,
          ),
        ));
  }

  Widget _buildPageView() {
    return PageView(
      controller: _presenter.pageController,
      onPageChanged: _presenter.pageChanged,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        GeneratorPage(key: _presenter.keyGenerator),
        HashtagPage(key: _presenter.keyHashTag),
        BannerPage(key: _presenter.keyBanner),
        MorePage(),
      ],
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
