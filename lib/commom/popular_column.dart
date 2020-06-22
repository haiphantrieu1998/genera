import 'package:flutter/material.dart';
import 'hashtag_button.dart';


class PopularColumn extends StatelessWidget {
  final String title;
  final String text;

  const PopularColumn({Key key, this.title, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFF2F3FC),
        ),
        height: 173.0,
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(title),
              subtitle: Text(text),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: ButtonHashtag(
                          buttonText: "copy",
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 1,
                        child: ButtonHashtag(
                          buttonText: "popularity",
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 1,
                        child: ButtonHashtag(
                          buttonText: "favorite",
                        ))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
