import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geneexpert/page/generator/model/recent_model.dart';
import 'package:geneexpert/themes/styles.dart';

class ItemGeneratorView extends StatelessWidget {
  final String text;
  final String name;
  final String textFunc;
  final Function onCopy;
  final Function onDelete;
  final RecentModel model;

  const ItemGeneratorView(
      {Key key,
      this.text,
      this.onCopy,
      this.name,
      this.textFunc,
      this.onDelete,
      this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: GEXStyles.purple3, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            model?.time ?? name ?? 'Group hashtag name',
            style: GEXStyles.copyStyle(
                color: GEXStyles.mainColor, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: GEXStyles.colorTv3))),
            child: Text(
              model?.hashtag ?? text ?? '...',
              style: GEXStyles.copyStyle(color: GEXStyles.tvgray),
            ),
          ),
          Row(
            children: <Widget>[
              _item('copy', onTap: () => onCopy(text)),
              _item('popularity'),
              _item(textFunc ?? 'delete', onTap: () => onDelete(model)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(String text, {Function onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: GEXStyles.gradient),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            text,
            style: GEXStyles.copyStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
