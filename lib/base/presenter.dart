import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geneexpert/auth/auth_state.dart';
import 'package:geneexpert/auth/bloc.dart';
import 'package:geneexpert/base/themes.dart';
import 'package:geneexpert/auth/apprepository.dart';
import 'package:geneexpert/themes/styles.dart';

import 'contract.dart';

abstract class Presenter {
  Presenter(this.context, this.view, {this.isPurchase = false}) {
    _init();
    init();
  }

  final BuildContext context;
  final Contract view;
  final ScrollController controller = ScrollController();
  List list = [];
  bool isFirst = true;
  final bool isPurchase;
  StreamSubscription _purchaseUpdatedSubscription;
  var box;

  void loadMore() {}

  Future onRefresh() {
    loadData();
    return Future.value(true);
  }

  int get coin => userRes.coin;

  bool get ratting => userRes.isRatting;

  List get listRecent => userRes.listRecent;

  AppRepository get userRes => RepositoryProvider.of<AppRepository>(context);

  Future _init() async {
    //2
    controller.addListener(_listener);
  }

  void _listener() {
    final maxScroll = controller.position.maxScrollExtent;
    if (controller.offset >= maxScroll && !controller.position.outOfRange) {
      loadMore();
    }
    ScrollPosition position = controller.position;
    if (position.userScrollDirection == ScrollDirection.reverse) {
      showAppBar();
    }
    if (position.userScrollDirection == ScrollDirection.forward) {
      hideAppBar();
    }
  }

  void showAppBar() {}

  void hideAppBar() {}

  void init() {}

  void loadData() {
    isFirst = false;
  }

  Future dispose() async {
    if (isPurchase) {
      if (_purchaseUpdatedSubscription != null) {
        await _purchaseUpdatedSubscription.cancel();
        _purchaseUpdatedSubscription = null;
      }
    }
  }

  void hideKeyBoard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void scrollToTop() {
    if (controller.offset == 0.0) {
      double heigh = MediaQuery.of(context).size.height;
      controller.jumpTo(-heigh);
    } else {
      print('Scrool to top');
      controller.animateTo(0.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }

  void onBack() {
    Navigator.of(context).pop();
  }

  bool _isShowDialog = false;

  void showLoading() {
    _isShowDialog = true;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator()
                      : const CupertinoActivityIndicator(
                          radius: 15,
                        ))),
        );
      },
    );
  }

  void showOderSuccess({String title}) {
    _isShowDialog = true;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'ORDER CREATED \nSUCCESSFULLY',
                        style:
                            Themes.copyStyle(color: Themes.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Themes.grey100,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    title ?? 'You will get your followers shortly',
                    style: Themes.copyStyle(color: Themes.grey200),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showOderFail({Function purchase}) {
    _isShowDialog = true;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'NOT ENOUGH COINS',
                        style:
                            Themes.copyStyle(color: Themes.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Themes.grey100,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Your coin balance is insufficient. Please purchase more coins.',
                    style: Themes.copyStyle(color: Themes.grey200),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: purchase,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Themes.mainColor,
                        borderRadius: BorderRadius.circular(30)),
                    alignment: Alignment.center,
                    child: Text(
                      'PURCHASE NOW',
                      style: Themes.copyStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget leadingView() {
//    if (user == null) return Container();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          child: Text(
            '$coin',
            style: GEXStyles.copyStyle(
                color: GEXStyles.yellow1,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget loadingView() {
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: Center(
            child: Platform.isAndroid
                ? const CircularProgressIndicator()
                : const CupertinoActivityIndicator(
                    radius: 15,
                  )));
  }

  Future hideLoading() async {
    if (!_isShowDialog) return;
    if (Navigator.of(context).canPop()) {
      return Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pop();
        _isShowDialog = false;
      });
    }
  }

  void showConfirm({Function callback, String title}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  title ?? 'Are you sure you want to delete?',
                  textAlign: TextAlign.center,
                  style: Themes.copyStyle(),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Themes.white100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'NO',
                            style: Themes.copyStyle(
                                color: Themes.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop();
                        callback();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          gradient: GEXStyles.gradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'YES',
                          style: Themes.copyStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void showNote(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Themes.copyStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.clear,
                          size: 24,
                          color: Themes.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Text(
                  content,
                  style: Themes.copyStyle(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
