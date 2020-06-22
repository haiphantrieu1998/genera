import 'package:flutter/material.dart';
import 'package:geneexpert/page/generator/view/item_generator_view.dart';
import 'package:geneexpert/themes/styles.dart';

class GeneratorDetailView extends StatelessWidget {
  final String text;

  const GeneratorDetailView({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: GEXStyles.mainColor,
        title: Text(
          'Result',
          style: GEXStyles.appBar(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: <Widget>[
          ItemGeneratorView(
            text: text,
            name: 'Niche Hashtags',
            textFunc: 'favorite',
          ),
          ItemGeneratorView(
            text: text,
            name: 'Related Hashtags',
            textFunc: 'favorite',
          ),
        ],
      ),
    );
  }
}
