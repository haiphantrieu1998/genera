import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/themes.dart';
import 'package:geneexpert/themes/styles.dart';
import '../menu_hashtag_model.dart';
import 'hashtag_detail_presenter.dart';

class HashtagDetailPage extends StatefulWidget {
  final MenuHashtagModel model;

  HashtagDetailPage({Key key, this.model}) : super(key: key);

  @override
  _HashtagDetailState createState() => _HashtagDetailState();
}

class _HashtagDetailState extends State<HashtagDetailPage> implements Contract {
  HashtagDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = HashtagDetailPresenter(context, this, widget.model);
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
        backgroundColor: GEXStyles.mainColor,
        actions: <Widget>[
         Padding(
           padding: const EdgeInsets.only(right: 20),
           child: Center(
            child: Text(
              '1000',
              style: GEXStyles.copyStyle(
                  fontWeight: FontWeight.bold,
                  color: GEXStyles.yellow1,
                  fontSize: 16),
            ),
        ),
         ),
        ],
        title: Text(_presenter.title, style: Themes.appBar()),
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
