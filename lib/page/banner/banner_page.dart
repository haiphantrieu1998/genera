import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/page/banner/banner_presenter.dart';
import 'package:geneexpert/themes/styles.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key key}) : super(key: key);

  @override
  BannerPageState createState() => BannerPageState();
}

enum popupMenu { a, b, c, d }

class BannerPageState extends State<BannerPage>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  BannerPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = BannerPresenter(context, this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: GEXStyles.mainColor,
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 13),
                child: PopupMenuButton<int>(
                    onSelected: _presenter.onSelected,
                    child: Image(
                      width: 24,
                      height: 24,
                      image: AssetImage('assets/icons/icon_banner.png')),
                    itemBuilder: _presenter.itemBuiderFilter),
              )
            ],
          leading: _presenter.leadingView(),
          title: Text(
            'Banner',
            style: GEXStyles.appBar(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            controller: _presenter.acontroller,
            itemCount: _presenter.list.length,
            itemBuilder: _presenter.itemBuilder));
  }

  @override
  void updateState() {
    setState(() {});
  }

  void scrollToTop() {
    _presenter.scrollToTop();
  }

  @override
  bool get wantKeepAlive => true;
}
