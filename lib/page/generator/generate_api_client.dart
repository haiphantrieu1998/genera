import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geneexpert/base/api_client.dart';
import 'package:geneexpert/core/api_note.dart';
import 'package:geneexpert/core/apis_copy.dart';
import 'package:hive/hive.dart';

import 'model/recent_model.dart';

class GenerateApiClient extends ApiClient {
  Box box;
  static final String _recent = 'recentKey';

  @override
  void init() async {
    super.init();
    box = await Hive.openBox(_recent);
  }

  Future addRecent(RecentModel model) async {
    box ??= await Hive.openBox(_recent);
    box.add(model);
    debugPrint('add Recent!');
  }

  Future getRecent() async {
    box ??= await Hive.openBox(_recent);
    return box.values.toList();
  }

  Future generate(int index, {File file, String url, String text}) {
    if (index == 1) {
      if (file == null) throw Exception('File is empty');
      return generateImage(file);
    } else if (index == 2) {
      if (url.isEmpty) throw Exception('Url is empty');
      return generateUrl(url);
    } else if (index == 3) {
      if (text.isEmpty) throw Exception('Keywork is empty');
      return genKeyword(text);
    }
    return null;
  }

  Future generateImage(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    var data = {
      "inputs": [
        {
          "data": {
            "image": {"base64": base64Image}
          }
        }
      ]
    };

    var hearders = {'Authorization': 'Key a88ce74ff01c47bfba7093087f681ac4'};
    Map res = await ApiM().methodPost(
        api: ApiConfig.generateImage, body: data, hearders: hearders);
    var outputs = res['outputs'];
    List<String> list = List();
    if (outputs != null && outputs is List && outputs.isNotEmpty) {
      var concepts = outputs[0]['data']['concepts'];
      for (var item in concepts) {
        String name = item['name'];
        list.add(name);
      }
    }
    debugPrint('List: $list');

    return list;
  }

  Future generateUrl(String url) async {
    var data2 = {
      "inputs": [
        {
          "data": {
            "image": {"url": url}
          }
        }
      ]
    };
    var hearders = {'Authorization': 'Key fc3fa361259b4beea47f6fbe9c8ad20d'};
    Map res = await ApiM().methodPost(
        api: ApiConfig.generateImage, body: data2, hearders: hearders);
    var outputs = res['outputs'];
    List list = List();
    if (outputs != null && outputs is List && outputs.isNotEmpty) {
      var concepts = outputs[0]['data']['concepts'];
      for (var item in concepts) {
        String name = item['name'];
        list.add(name);
      }
    }
    debugPrint('List: $list');

    return list;
  }

  Future genKeyword(String text) async {
    var url = 'https://api.datamuse.com/words?ml=$text&max=30';
    List res = await ApiM().methodGet(
      api: url,
    );
    print('GenerateApiClient getKeyword :$res');
    List list = List();
    try {
      if (res != null && res.isNotEmpty)
        list = res.map((f) => f['word']).toList();
    } catch (e) {
      debugPrint('genKeyword $e');
    }
    return list;
  }
}
