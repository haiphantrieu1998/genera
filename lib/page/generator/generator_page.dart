import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/page/generator/generator_presenter.dart';
import 'package:geneexpert/themes/styles.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GeneratorPageState();
}

class GeneratorPageState extends State<GeneratorPage>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  GeneratorPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = GeneratorPresenter(context, this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: GEXStyles.mainColor,
        leading: _presenter.leadingView(),
        title: Text(
          'HashTag Generator',
          style: GEXStyles.appBar(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        controller: _presenter.controller,
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 14),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: GEXStyles.purple3,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _itemContainer(1, _presenter.onChange),
                    SizedBox(
                      width: 15,
                    ),
                    _itemContainer(2, _presenter.onChange),
                    SizedBox(
                      width: 15,
                    ),
                    _itemContainer(3, _presenter.onChange),
                  ],
                ),
                _buildBody(),
                GestureDetector(
                  onTap: _presenter.onGenerator,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xffC45CCB),
                              Color(0xff7D5FD3),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        color: GEXStyles.mainColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Text(
                      'Generator',
                      style: GEXStyles.copyStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            'Recent Generator',
            style: GEXStyles.copyStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: _presenter.itemRecent,
              itemCount: _presenter.list.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_presenter.index == 1) {
      String fileName = _presenter?.imagesPickers?.path?.split('/')?.last;
//      String fileName2 = basename(_presenter?.imagesPickers?.path);
      return GestureDetector(
        onTap: _presenter.onImage,
        child: Container(
          margin: EdgeInsets.only(top: 24, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/icons/ic_upload.png'),
                width: 18,
                height: 18,
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(
                  '${fileName ?? 'Choose a file...'}',
                  style: GEXStyles.copyStyle(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (_presenter.index == 2) {
      return Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: 32),
            margin: EdgeInsets.only(top: 24, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5),
                  height: 32,
                  padding: EdgeInsets.all(8),
                  color: GEXStyles.mainColor,
                  child: Image(
                    image: AssetImage('assets/icons/ic_instagram.png'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(maxWidth: 220),
                  child: TextField(
                    autocorrect: false,
                    autofocus: false,
                    controller: _presenter.textController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 18),
                        border: InputBorder.none,
                        hintText: 'Example: www.instagram.com',
                        hintStyle: GEXStyles.copyStyle(
                            fontSize: 12, color: GEXStyles.black2)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (_presenter.index == 3) {
      return Container(
        constraints: BoxConstraints(maxHeight: 32),
        margin: EdgeInsets.only(top: 24, bottom: 10),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.all(8),
              color: GEXStyles.mainColor,
              child: Image(
                image: AssetImage('assets/icons/ic_hashtag.png'),
                color: Colors.white,
              ),
            ),
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 220),
              child: TextField(
                autocorrect: false,
                autofocus: false,
                controller: _presenter.textController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 18),
                    border: InputBorder.none,
                    hintText: 'Example: love',
                    hintStyle: GEXStyles.copyStyle(
                        fontSize: 12, color: GEXStyles.black2)),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  Widget _itemContainer(int pos, Function(int value) onTap) {
    String image;
    String text;
    bool color = false;
    if (pos == 1) {
      image = 'assets/icons/image_photo.png';
      text = 'Photo';
      if (pos == _presenter.index) {
        image = 'assets/icons/active_photo.png';
        color = true;
      }
    }
    if (pos == 2) {
      image = 'assets/icons/image_url.png';
      text = 'Post Url';
      if (pos == _presenter.index) {
        image = 'assets/icons/active_url.png';
        color = true;
      }
    }
    if (pos == 3) {
      image = 'assets/icons/image_keyword.png';
      text = 'Keyword';
      if (pos == _presenter.index) {
        image = 'assets/icons/active_keyword.png';
        color = true;
      }
    }
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(pos),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(image),
                height: 48,
                width: 48,
              ),
              Text(
                text,
                style: GEXStyles.copyStyle(
                    fontWeight: FontWeight.bold,
                    color: color ? Colors.black : GEXStyles.tvgray),
              )
            ],
          ),
        ),
      ),
    );
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
