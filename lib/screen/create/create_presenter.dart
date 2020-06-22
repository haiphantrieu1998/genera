import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/presenter.dart';
import 'package:geneexpert/screen/create/hashtagdb.dart';
import 'package:sqflite/sqflite.dart';

import 'hashtag_create_model.dart';


class CreatePresenter extends Presenter {
  CreatePresenter(BuildContext context, Contract view) : super(context, view);
   TextEditingController userController = new TextEditingController();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<HashTag> hashtagList;
  HashTag  hashtag;
  int count = 0;

  void createPresenter(){
    hashtag = HashTag('');
    if(hashtagList == null){
      hashtagList = List<HashTag>();
      updateList();
    }
  }

  void updateList(){
    final Future<Database> dbFuture = _databaseHelper.initializedDatabase();
    dbFuture.then((database){
      Future<List<HashTag>> hashTagListFuture = _databaseHelper.getHashTagList();
      hashTagListFuture.then((hashtagList){
        this.hashtagList = hashtagList;
        this.count = hashtagList.length;
        view.updateState();
      });
    });
  }
  void deleteFunction(BuildContext context, int index) async {
    await _databaseHelper.deleteHashTag(hashtagList[index].id);
    updateList();
  }
  void update(){
    hashtag.name = userController.text; 
  }
  void addFunction(){
    _databaseHelper.inserHashTag(hashtag);
    updateList();
  }
  void refresh(){
    userController.text = '';
  }
  @override
  void loadData() {
    super.loadData();
  }
}
