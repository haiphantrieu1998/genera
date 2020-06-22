import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/themes.dart';
import 'package:geneexpert/screen/favorite/favorite_presenter.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> implements Contract {
  FavoritePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = FavoritePresenter(context, this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFF5C3A7B),
        actions: <Widget>[],
        title: Text("Favorite Hashatgs", style: Themes.appBar()),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _presenter.list.length,
        itemBuilder: _presenter.itemBuilder,
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
