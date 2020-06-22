import 'package:flutter/material.dart';
import 'package:geneexpert/page/banner/banner_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ItemBannerView extends StatelessWidget {
  final Function(BannerModel value) onCopy;
  final BannerModel model;
  final int index;
  final AutoScrollController controller;

  const ItemBannerView(
      {Key key, this.model, this.index, this.controller, this.onCopy})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String name = model.name;
    String content = model.content;
    return AutoScrollTag(
      controller: controller,
      key: ValueKey(index),
      index: index,
      child: Padding(
        padding: EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 3),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2F3FC),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(content),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _bannerButton('Copy', onTap: _onCopy),
                      _bannerButton('Popularity', onTap: null),
                      _bannerButton('Favourite', onTap: null),
                    ],
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerButton(String dataButton, {Function onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 25,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFC45CCB),
              Color(0xFF7D5FD3),
            ]),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            dataButton,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _onCopy() {
    onCopy(model);
  }
}
