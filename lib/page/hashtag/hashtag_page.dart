import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/themes.dart';
import 'package:geneexpert/page/hashtag/hashtag_presenter.dart';
import 'package:geneexpert/screen/create/create_page.dart';
import 'package:geneexpert/themes/styles.dart';

class HashtagPage extends StatefulWidget {
  const HashtagPage({Key key}) : super(key: key);

  @override
  HashtagPageState createState() => HashtagPageState();
}

class HashtagPageState extends State<HashtagPage>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  HashtagPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = HashtagPresenter(context, this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        centerTitle: true,
        leading: _presenter.leadingView(),
        title: Text(
          "Hashtags",
          style: Themes.appBar(),
        ),
        backgroundColor: GEXStyles.mainColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              //todo: Action
            },
          ),
          IconButton(
            onPressed: () {
              // _onDetail(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CreateView()));
            },
            icon: Icon(
              Icons.add,
              size: 24,
              color: GEXStyles.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _presenter.controller,
        itemBuilder: _presenter.itemBuilder,
        itemCount: _presenter.list.length,
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }

  void scrollToTop() {
    _presenter.scrollToTop();
  }

  @override
  bool get wantKeepAlive => true;
}
