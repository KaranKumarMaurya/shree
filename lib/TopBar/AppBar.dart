import 'package:flutter/material.dart';
import 'package:sgj/components/Bag/Bag.dart';
import 'package:flutter/cupertino.dart';
import 'package:sgj/components/Search/CloudFirestoreSearch.dart';

class TheAppBar extends AppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
        title: Text("Shree Ganga Jewellers",
          style: TextStyle(color: Colors.white, fontFamily: 'Raleway',),
        ),
        titleSpacing: 1.0,
        // leading: IconButton(
        //   //  padding : EdgeInsets.only(left : 1.0, right : 1.0)  ,
        //     icon: Icon(Icons.dehaze_sharp,
        //         color: Colors.black),
        // ),
        actions: [
          IconButton(
            icon: Icon(
                Icons.search,
                color: Colors.black),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return CloudFirestoreSearch();
              }));
            },
          ),
          IconButton(
              icon: Icon(Icons.shopping_bag_outlined,
                  color: Colors.black),
            onPressed: (){
                return Bag();
            },
          )
        ]
    );
  }
}
