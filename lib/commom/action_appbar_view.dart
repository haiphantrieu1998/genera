import 'package:flutter/material.dart';


class ActionAppBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return InkWell(
      onTap: () {},
      child: Row(
        children: <Widget>[
          Text(
            '1000',
            style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2, right: 10),
            child: Icon(Icons.monetization_on,color: Colors.yellow,)
          )
        ],
      ),
    );
    // }
    // );
  }
}
