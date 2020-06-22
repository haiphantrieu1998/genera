import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/presenter.dart';
import 'package:geneexpert/base/utils.dart';
import 'package:geneexpert/core/database.dart';
import 'package:geneexpert/page/hashtag/detail/detail_model.dart';
import 'package:geneexpert/screen/favorite/favorite_api_client.dart';
import 'package:geneexpert/screen/favorite/favorite_model.dart';
import 'package:geneexpert/themes/styles.dart';

import '../menu_hashtag_model.dart';
import 'item_hashtag_detail_view.dart';

class HashtagDetailPresenter extends Presenter {
  final MenuHashtagModel model;
  final TextEditingController _titleController = TextEditingController();

  String get title => model.name;

  HashtagDetailPresenter(BuildContext context, Contract view, this.model)
      : super(context, view);

  @override
  void init() async {
    super.init();
  }

  Widget itemBuilder(BuildContext context, int index) {
    DetailModel model = list[index];
    return ItemHashtagDetailView(
      model: model,
      onCopy: onCopy,
      onFavorite: _formShowDialog,
    );
  }

  @override
  void loadData() async {
    super.loadData();
    list = await DBProvider.db.getContents(model.id);
    debugPrint(model.name);
    view.updateState();
  }

  void onCopy(DetailModel value) {
    try {
      Clipboard.setData(ClipboardData(text: value.tags));
      Utils.showToast('Copy success !');
    } catch (e) {
      debugPrint('Lỗi ở onCopy :$e');
      Utils.showToast('Copy fail !');
    }
  }

  void _addFavorite(DetailModel value) async {
    final key = _titleController.text;
    final newFavorite = FavoriteModel(title: key, content: value.tags);
    FavoriteApiClient().addFavorite(newFavorite);
  }

  //todo: ShowDialog
  void _formShowDialog(DetailModel value) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return SingleChildScrollView(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'Create Title',
                style: TextStyle(color: GEXStyles.tvgray, fontSize: 16),
              ),
            ),
            content: Container(
              width: 300,
              height: 170,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                      borderRadius: BorderRadiusDirectional.circular(30),
                    ),
                    child: TextField(
                      controller: _titleController,
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Your Title...",
                          contentPadding: new EdgeInsets.only(left: 20),
                          border: InputBorder.none),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _addFavorite(value);
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 11, bottom: 11),
                      child: Center(
                        child: Text(
                          "Done",
                          style: GEXStyles.copyStyle(
                              color: GEXStyles.white,
                              fontSize: GEXStyles.sizeFont,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            Color(0xffC45CCB),
                            Color(0xff7D5FD3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
