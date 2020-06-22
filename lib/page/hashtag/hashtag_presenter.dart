import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/presenter.dart';
import 'package:geneexpert/page/hashtag/menu_hashtag_model.dart';
import 'item_hashtag_view.dart';

class HashtagPresenter extends Presenter {
  HashtagPresenter(BuildContext context, Contract view) : super(context, view);

  @override
  void init() async {
    super.init();
  }

  Widget itemBuilder(BuildContext context, int index) {
    MenuHashtagModel model = list[index];
    return ItemHashtagView(
      model: model, //todo: truyền dữ liệu model sang trang ItemHashtagView()
    );
  }
  //todo: load Json Asset 
  @override
  void loadData() async {
    super.loadData();
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/menu_hashtag.json");
        debugPrint(data);

    //todo:  Decoding this raw json String we got.
    //todo:  And now we are deserializing the decoded json response by calling
    //todo: the Student.fromJson method so that we can now use Student object to access our entities.
    final jsonResult = json.decode(data);
    list = MenuHashtagList.fromJson(jsonResult).list;
    view.updateState();
  }
}
