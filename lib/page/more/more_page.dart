import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/page/more/views/time_view.dart';
import 'package:geneexpert/themes/styles.dart';
import 'more_presenter.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key key}) : super(key: key);

  @override
  MorePageState createState() => MorePageState();
}

class MorePageState extends State<MorePage>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  final GlobalKey<TimeViewState> timekey = GlobalKey();
  MorePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = MorePresenter(context, this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: GEXStyles.bg,
      appBar: AppBar(
        backgroundColor: GEXStyles.mainColor,
        brightness: Brightness.dark,
        leading: _presenter.leadingView(),
        title: Text(
          'More',
          style: GEXStyles.appBar(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          _item('assets/icons/check_in.png', 'Check in',
              number: '+5',
              color: GEXStyles.mainColor,
              isTime: true,
              onClick: _presenter.checkin),
          _item('assets/icons/video.png', 'Watch a short video',
              number: '+2', color: GEXStyles.mainColor, onClick: _presenter.showAds
//                  () {
//            if (i < 5) {
//              i++;
//            }}
            ),
          Visibility(
            visible: !_presenter.isRatting,
            child: _item(
              'assets/icons/ngoisao.png',
              'Rating us',
              number: '+5',
              color: GEXStyles.mainColor,
              onClick: _presenter.onRatting,
            ),
          ),
          _item('assets/icons/ngoisao.png', 'Favorite Hashatgs',
              isNext: true, onClick: _presenter.onFavorites),
          _item('assets/icons/ic_hashtag.png', 'Your Hashatgs', isNext: true),
          _item('assets/icons/setting.png', 'Setting', isNext: true,
          onClick: _presenter.onSetting),
          _item('assets/icons/remove_ads.png', 'Remover Ads'),
          _item('assets/icons/restore.png', 'Restore Purchase'),
          _item('assets/icons/100.png', 'Purchase package',
              number: '\$1.99', color: GEXStyles.blueMain),
        ],
      ),
    );
  }

  Widget _item(String icon, String title,
      {String number,
      bool isNext = false,
      Color color,
      bool isTime = false,
      Function onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0),
              spreadRadius: 0,
              blurRadius: 2,
//            offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 46,
              height: 46,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  color: Color(0XFFFFF7E2),
                  borderRadius: BorderRadius.circular(8)),
              child: Image(width: 22, height: 22, image: AssetImage(icon)),
            ),
            Expanded(
              child: Text(
                title,
                style: GEXStyles.copyStyle(fontSize: 20),
              ),
            ),
            isTime
                ? Expanded(
                    child: TimeView(
                    key: _presenter.timerKey,
//                        time: onClick ,
                  ))
                : Container(),
            number != null
                ? Text(
                    number,
                    style:
                        GEXStyles.copyStyle(color: color ?? GEXStyles.colorTv1),
                  )
                : Container(),
            isNext ? Icon(Icons.chevron_right) : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void updateState() {
//    Timer(Duration(seconds: 10),(){
    setState(() {});
//    });
  }

  @override
  bool get wantKeepAlive => true;

//  void sdfsf() {
//    timekey.currentState;
//  }
}
