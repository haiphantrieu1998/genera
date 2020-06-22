import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/themes.dart';
import 'package:geneexpert/themes/styles.dart';
import 'create_presenter.dart';

class CreateView extends StatefulWidget {
  const CreateView({Key key}) : super(key: key);
  @override
  _CreateViewState createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> implements Contract {
  CreatePresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = CreatePresenter(context, this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
    _presenter.createPresenter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          "Create hashtags",
          style: Themes.appBar(),
        ),
        centerTitle: true,
        backgroundColor: GEXStyles.mainColor,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 10,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: GEXStyles.sizeFont,
                  color: GEXStyles.colorNeutral11,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: TextField(
                        controller: _presenter.userController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Write hashtag...",
                          labelStyle: TextStyle(
                            fontSize: GEXStyles.sizeFont,
                            color: GEXStyles.tvgray,
                          ), // inputDecoration
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: () {
                          _presenter.update();
                          _presenter.addFunction();
                          _presenter.updateList();
                          _presenter.refresh();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: const [
                                Color(0xffC45CCB),
                                Color(0xff7D5FD3),
                              ],
                            ),
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.add,
                            size: 24,
                            color: GEXStyles.white,
                          ),
                          // color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: GridView.count(
                  childAspectRatio: (5), //size Of GridView
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: _buildGridTiles(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGridTiles() {
    List<Container> containers = new List<Container>.generate(
      _presenter.count,
      (int index) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xffC45CCB),
                Color(0xff7D5FD3),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.purple,
          ),
          child: Stack(
            alignment: const Alignment(0.6, 0.6),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 5),
                            // padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "${_presenter.hashtagList[index].name}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height/30,
                right: 15,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                      _presenter.deleteFunction(context, index);
                    },
                    child: Container(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    return containers;
  }

  @override
  void updateState() {
    setState(() {});
  }
}
