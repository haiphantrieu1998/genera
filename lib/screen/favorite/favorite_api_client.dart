import 'package:flutter/material.dart';
import 'package:geneexpert/base/api_client.dart';
import 'package:geneexpert/base/utils.dart';
import 'package:geneexpert/screen/favorite/favorite_model.dart';
import 'package:hive/hive.dart';

class FavoriteApiClient extends ApiClient {
  Box box;
  static final String _favoriteKey = 'abcfavoriteKey';
  @override
  void init() async{
    super.init();
    box = await Hive.openBox(_favoriteKey);
  }

  Future addFavorite(FavoriteModel model)async{
    box ??=  await Hive.openBox(_favoriteKey);
    box.add(model);
    Utils.showToast('Add favorite success');
  }

  Future<List> getFavorite()async{
    box ??=  await Hive.openBox(_favoriteKey);
    debugPrint('FavoriteApiClient getFavorite ${box.values}');
    return box.values.toList();
  }
    Future deleteFavorite(key)async{
    box ??=  await Hive.openBox(_favoriteKey);
    box.deleteAt(key);
    Utils.showToast('Delete favorite success');
  }
}