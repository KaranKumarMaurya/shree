// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ProductDisplayGrid extends StatelessWidget {
//   final CollectionReference _productRef = FirebaseFirestore.instance.collection("Products");
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     final screen_height = MediaQuery.of(context).size.height/3;
//     final screen_width = MediaQuery.of(context).size.width/2;
//     final small_padding = (MediaQuery.of(context).size.height)/100;
//     final category_padding = small_padding * 5;
//     return  Container(
//         height: screen_height,
//         child : FutureBuilder<QuerySnapshot>(
//             future : _productRef.get(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Scaffold(
//                     body: Center(
//                       child: Text("Error : ${snapshot.error}"),
//                     )
//                 );
//               }
//
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return GridView.count(
//                     physics: ScrollPhysics(),
//                     scrollDirection: Axis.vertical,
//                     crossAxisCount: 2,
//                     children: snapshot.data.docs.map((document) {
//                       return Container(
//                         padding: EdgeInsets.all(4.0),
//                         child: Container(
//
//                           color: Colors.white,
//                           child: Center(
//                             child: Column(
//                                 children: [
//                                   Flexible(
//                                     flex: 4,
//                                     child: Container(
//                                       child: Image.network(
//                                         "${document.data()['images'][3]}",
//                                         fit: BoxFit.fill,),
//                                     ),
//                                   ),
//
//                                   Flexible(
//                                     flex: 1,
//                                     child: Container(
//                                       padding: EdgeInsets.only(top: category_padding/4.5),
//                                       child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.all(2.0),
//                                               child: Text( '\u20B9' + " " + "${document.data()['display_price']}",
//                                                 style: TextStyle(fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(left : 2.0,top: 1.0),
//                                               child: Text('\u20B9' + "${document.data()['price']}",
//                                                 style: TextStyle(
//                                                     fontSize: 13,
//                                                     color: Colors.blueGrey,
//                                                     decoration: TextDecoration.lineThrough
//                                                 ),
//                                               ),
//                                             )
//                                           ]
//                                       ),
//                                     ),
//                                   )
//                                 ]),
//                           ),
//                           //        ),
//                         ),
//                       );
//
//                     }
//
//                     ).toList()
//                 );
//               }
//
//               return Scaffold(
//                   body: Center(
//                     child: CircularProgressIndicator(),
//                   )
//               );
//             }
//         )
//
//     );
//   }
//
//
//
//
//
// }
