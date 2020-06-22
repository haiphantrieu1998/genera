import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Future request(
    {String method,
    String api,
      Map<String, dynamic> headers,
    Object body,
      Map<String, dynamic> queries}) async {
  debugPrint('$headers');
  debugPrint('$body');
  debugPrint('$queries');
  debugPrint(api);
    Response response;
    final dio = Dio();
    response = await dio.request(api,
        data: body,
        queryParameters: queries,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: headers,
            method: method,
            responseType: ResponseType.json));
    return response.data;
  
}

class ApiM {
  Future methodGet({@required String api, Map<String, dynamic> queries, Map<
      String,
      dynamic> hearders}) {
    return request(
        method: 'GET', headers: hearders, queries: queries, api: api);
  }

  Future methodPost(
      {@required String api, Object body, Function onSendProgress, Map<
          String,
          dynamic> hearders}) {
    return request(method: 'POST', headers: hearders, body: body, api: api);
  }

  Future methodPut(
      {@required String api, Object body, Map<String, dynamic> hearders}) {
    return request(method: 'PUT', headers: hearders, body: body, api: api);
  }

  Future methodDel(
      {@required String api, Object body, Map<String, dynamic> hearders}) {
    return request(method: 'DELETE', headers: hearders, body: body, api: api);
  }
}
