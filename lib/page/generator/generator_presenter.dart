import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geneexpert/auth/bloc.dart';
import 'package:geneexpert/base/const.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/presenter.dart';
import 'package:geneexpert/base/utils.dart';
import 'package:geneexpert/page/generator/model/recent_model.dart';
import 'package:geneexpert/page/generator/view/item_generator_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'generate_api_client.dart';
import 'view/generator_detal_view.dart';

class GeneratorPresenter extends Presenter {
  int index = 1;
  TextEditingController textController = TextEditingController();
  GenerateApiClient _apiClient;
  File imagesPickers;
  String hashTag = '';

  GeneratorPresenter(BuildContext context, Contract view)
      : super(context, view);

  @override
  void init() {
    super.init();
    _apiClient = GenerateApiClient();
  }

  @override
  void loadData() async {
    list = await _apiClient.getRecent();
    view.updateState();
  }

  void onChange(int value) {
    index = value;
    imagesPickers = null;
    textController.clear();
    view.updateState();
  }

  void onGenerator() async {
    hashTag = '';
    String text = textController.text;
    String url;
    if (text != null || text != '') {
      url = '$text/media';
    }
    if (userRes.coin < 20) {
      showConfirm(
          title: 'Your coin is not enough\nDo you want to buy Coin?',
          callback: _buyCoin);
      return;
    }
    try {
      showLoading();
      List results = await _apiClient.generate(index,
          file: imagesPickers, url: url, text: text);
      for (int i = 0; i < results.length; i++) {
        hashTag += '#${results[i]} ';
      }
      DateTime timeNow = DateTime.now();
      String time2 = DateFormat(Const.time_format).format(timeNow);
      RecentModel model = RecentModel();
      model.time = time2;
      model.hashtag = hashTag;
      list.add(model);
      await hideLoading();
      BlocProvider.of<AuthBloc>(context).add(CoinChangeEvent(-20));
      _apiClient.addRecent(model);
      imagesPickers = null;
      textController.clear();
      view.updateState();
      hideKeyBoard();
      Utils.navigatePage(
          context,
          GeneratorDetailView(
            text: hashTag,
          ));
    } catch (e) {
      hideLoading();
      debugPrint('Lỗi ở onGenerator :$e');
      await hideLoading();
      Utils.showToast(e.message);
    }
  }

  void onImage() async {
    Utils.askPermissionPhotos(context, () async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 1024,
          maxWidth: 1024,
          imageQuality: 70);
      if (image != null) {
        imagesPickers = image;
        view.updateState();
      }
    });
  }

  Widget itemRecent(BuildContext context, int index) {
    RecentModel model = list[index];
    return ItemGeneratorView(
      model: model,
      onCopy: onCopy,
      onDelete: _onDelete,
    );
  }

  void onCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Utils.showToast('Copy success !');
  }

  void _onDelete(RecentModel model) {
    showConfirm(callback: () => _delete(model), title: 'You are sure delete?');
  }

  void _delete(RecentModel model) {
    showLoading();
    list.remove(model);
    model.delete();
    hideLoading();
    Utils.showToast('Delete success!');
    view.updateState();
  }

  _buyCoin() {}
}
