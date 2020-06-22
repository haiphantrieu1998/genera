import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/screen/setting/setting_presenter.dart';
import 'package:geneexpert/themes/styles.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
//    with AutomaticKeepAliveClientMixin
    implements Contract {
  SettingPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = SettingPresenter(context, this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: GEXStyles.mainColor,
//        leading: Icon(Icons.chevron_left,color: Colors.white,size: 40,),
        title: Text(
          'Setting',
          style: GEXStyles.appBar(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          _item('Privacy policy',),
          Divider(indent: 15,endIndent: 10,),
          _item('Tem of use'),
          Divider(indent: 15,endIndent: 10,),
          _item('Feedback'),
          Divider(indent: 15,endIndent: 10,)
        ],
      ),
    );
  }

  Widget _item (String tittle ){
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Text(
        tittle, style: GEXStyles.copyStyle(fontSize: 20),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }

//  @override
//  bool get wantKeepAlive => true;
}