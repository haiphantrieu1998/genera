import 'package:flutter/material.dart';
import 'package:geneexpert/base/themes.dart';
import 'package:geneexpert/screen/favorite/favorite_model.dart';
import 'package:geneexpert/themes/styles.dart';

class ItemFavoriteView extends StatelessWidget {
  final FavoriteModel model;
  final Function(FavoriteModel value) onCopy;
  // final Function(FavoriteModel value) onFavorite;

  ItemFavoriteView({Key key, this.model, this.onCopy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = model?.title ?? '';
    String content = model?.content ?? '';
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: GEXStyles.purple3,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    name,
                    style: Themes.copyStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    content,
                    style: Themes.copyStyle(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _itemButton('Copy', onTap: _onCopy),
                      _itemButton(
                        'Popularity',
                      ),
                      _itemButton(
                        'Delete',
                        onTap: _onDelete,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemButton(String text, {Function onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 25,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xffC45CCB),
                Color(0xff7D5FD3),
              ],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            text,
            style: GEXStyles.copyStyle(
                color: GEXStyles.white,
                fontSize: GEXStyles.sizeFont,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // void _onFavorite() {
  //   onFavorite(model);
  // }

  void _onCopy() {
    onCopy(model);
  }

  void _onDelete() {
    print("delete");
  }
}
