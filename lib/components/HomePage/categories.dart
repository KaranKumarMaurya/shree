import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sgj/components/Search/SearchResults.dart';

class categories extends StatelessWidget {

  final CollectionReference _catRef = FirebaseFirestore.instance.collection("gold_categories");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    final small_padding = (MediaQuery.of(context).size.height)/100;
    final category_padding = small_padding * 5;
    return  Container(
        height: screen_height/6.3,
              child : FutureBuilder<QuerySnapshot>(
                future : _catRef.orderBy("ID").get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                        body: Center(
                          child: Text("Error : ${snapshot.error}"),
                        )
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {

                    return ListView(
                        padding: EdgeInsets.all(small_padding),
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data.docs.map((document) {
                          Map<String, dynamic> docData = document.data();
                          return Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.fromLTRB(3.0, 2.0, 3.0,2.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResults(value : ("${docData['Name']}").toLowerCase()) )); //test route
                              },
                              child: Container(
                              //  padding : EdgeInsets.only(right: 15.0),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.blueGrey),
                                    color: Colors.white,
                                    shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                                    //color: const Color(0xFF66BB6A),
                                    boxShadow: [BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                    ),]
                                ),

                                                width: screen_height/7,
                                               child: Center(
                                                 child: Column(
                                                   children: [Container(
                                                       padding: EdgeInsets.only(top: category_padding/1.5),
                                                       height: screen_width/8,
                                                       child: SvgPicture.network(
                                                           "${docData['Image']}")),

                                                    Container(
                                                      padding: EdgeInsets.only(top: category_padding/2),
                                                      child: Text("${docData['Name']}",
                                                       ),
                                                    )
                                                   ]),
                                               ),
                              ),
                            ),
                          );

                        }

                        ).toList()
                    );
                  }
                  return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      )
                  );
                }
    )





        //       height: screen_height/6.3,
        //       child: ListView(
        //         padding: EdgeInsets.all(small_padding),
        //         scrollDirection: Axis.horizontal,
        //         children: [
        //           Container(
        //               width: screen_height/7,
        //               color: Colors.red)
        //         ],
        // )
    );
  }

  // Future<DocumentSnapshot> getData() async {
  //   await Firebase.initializeApp();
  //   return await FirebaseFirestore.instance
  //       .collection("gold_categories")
  //       .orderBy("ID", "asc")
  //       .get();
  // }
}



