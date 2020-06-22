import 'dart:convert';

import 'package:flutter/material.dart';


class TextBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/jsons/banner.json'),
          builder: (context, snapshot) {
            var bannerdata = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        color: Color(0xFFf2e9e9),
                        child: ListTile(
                          title: Text(bannerdata[index]['name']),
                          subtitle: Text(bannerdata[index]['content']),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: bannerdata == null ? 0 : bannerdata.length,
            );
          },
        ),
      ),
    );
  }
}
