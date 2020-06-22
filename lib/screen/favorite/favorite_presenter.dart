import 'package:flutter/material.dart';
import 'package:geneexpert/base/contract.dart';
import 'package:geneexpert/base/presenter.dart';
import 'package:geneexpert/screen/favorite/favorite_api_client.dart';
import 'package:geneexpert/screen/favorite/favorite_model.dart';

import 'item_favorite_view.dart';

class FavoritePresenter extends Presenter {
  FavoriteApiClient _apiClient = FavoriteApiClient();
  FavoritePresenter(BuildContext context, Contract view) : super(context, view);


  @override
  void loadData()async {
    super.loadData();
    List abc = await _apiClient.getFavorite();
    list.addAll(abc);
    view.updateState();
  }

  Widget itemBuilder(BuildContext context, int index) {
    FavoriteModel model = list[index];
    return ItemFavoriteView(model: model,);
  }
  void delete()async{
  
  }
}