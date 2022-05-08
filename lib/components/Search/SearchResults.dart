import 'package:flutter/material.dart';
import 'package:sgj/TopBar/SideDrawer.dart';
import 'package:sgj/components/HomePage/product_display_grid.dart';

class SearchResults extends StatelessWidget {
  SearchResults({@required this.value});
  final String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //     title: Text("Cart",
      //       style: TextStyle(color: Color(0xFF0B0086)),
      //     ),
      //     titleSpacing: 1.0,
      //     // leading: IconButton(
      //     //   //  padding : EdgeInsets.only(left : 1.0, right : 1.0)  ,
      //     //     icon: Icon(Icons.dehaze_sharp,
      //     //         color: Colors.black),
      //     // ),
      //     actions: [
      //       IconButton(
      //         icon: Icon(
      //             Icons.search,
      //             color: Colors.black),
      //         onPressed: (){
      //           Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //             return CloudFirestoreSearch();
      //           }));
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.shopping_bag_outlined,
      //             color: Colors.black),
      //         onPressed: (){
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => Bag() ));
      //         },
      //       )
      //     ]
      // ),
      body: SingleChildScrollView(child: ProductDisplayGrid(name : value)),
    );
  }
}
