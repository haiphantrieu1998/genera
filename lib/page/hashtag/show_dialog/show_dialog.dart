import 'package:flutter/material.dart';

class ShowDiaLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();

    //     showDialog(
    // context: context,
    // builder: (context) {
    //   return AlertDialog(
    //     shape:
    //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //     content: Container(
    //       width: 500,
    //       height: 220,
    //       child: Column(
    //         children: <Widget>[
    //           SizedBox(
    //             width: 30,
    //           ),
    //           Text("Create Title",style: TextStyle(fontWeight: FontWeight.bold),),
    //           SizedBox(
    //             height: 15,
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(bottom: 15, top: 15),
    //             decoration: BoxDecoration(
    //               color: Color(0xfff2f2f2),
    //               borderRadius: BorderRadiusDirectional.circular(50),
    //             ),
    //             child: TextField(
    //               decoration: InputDecoration(
    //                   hintText: "Your Title...",
    //                   contentPadding: new EdgeInsets.only(left: 20),
    //                   border: InputBorder.none),
    //               keyboardType: TextInputType.text,
    //               autocorrect: false, // cái
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    //             },
    //             child: Container(
    //               width: MediaQuery.of(context).size.width,
    //               padding: EdgeInsets.only(top: 11, bottom: 11),
    //               child: Center(
    //                 child: Text(
    //                   "Done",
    //                   style: TextStyle(color: Colors.white, fontSize: 16),
    //                 ),
    //               ),
    //               decoration: BoxDecoration(
    //                 color: Color(0xffA561DB),
    //                 borderRadius: BorderRadius.circular(15),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    //   },
    //   child: Icon(Icons.add),
    // );
  }
}
