import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/presenter.dart';
import 'package:geneexpert/base/themes.dart';
import 'package:geneexpert/base/utils.dart';
import 'package:geneexpert/page/banner/banner_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'item_banner_view.dart';

class BannerPresenter extends Presenter {
  BannerPresenter(BuildContext context, Contract view) : super(context, view);

  AutoScrollController acontroller;

  @override
  void init() {
    super.init();
    acontroller = AutoScrollController(
      axis: Axis.vertical
    );
  }
  
  @override
  void loadData() async{
    super.loadData();
    String data = await DefaultAssetBundle.of(context).loadString("assets/jsons/banner.json");
    final jsonResult = json.decode(data);
    list = BannerModelList.fromJson(jsonResult).list;
    view.updateState();
  }
  

  Widget itemBuilder(BuildContext context, int index) {
    BannerModel model = list[index];
    return ItemBannerView(model:model, index: index,controller: acontroller,);
  }

  void onSelected(int value)async{
    await acontroller.scrollToIndex(value, preferPosition: AutoScrollPosition.begin);
    acontroller.highlight(value);
  }

  void onCopy(BannerModel value) {
    try{
      Clipboard.setData(ClipboardData(text: value.content));
      Utils.showToast('Coppy Success');
    }catch(e){
      debugPrint('Lỗi ở onCopy :$e');
      Utils.showToast('Copy fail !');
    }
  }
  

  List<PopupMenuEntry<int>> itemBuiderFilter(BuildContext context) {
    int i = -1;
     return list.map((e){
        i ++ ;
        return PopupMenuItem<int>(
              value: i,
              child: Text(e.name,style: Themes.copyStyle(),),
            );
      },).toList();
  }

  @override
  void scrollToTop() {
    acontroller.animateTo(0.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
  }
}
