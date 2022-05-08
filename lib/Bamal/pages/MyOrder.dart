import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgj/components/Bag/Bag.dart';
import 'package:sgj/components/HomePage/product_display_grid.dart';
import 'package:strings/strings.dart';
//import 'package:sgj/Bamal/pages/practice.dart';

class MyOrders extends StatelessWidget {
  bool val = false;
//  int currentValue;
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference orderRef;

  //  currentValue = int.parse(snapshot.data.docs[index].data()["quantity"].toString());

  @override
  Widget build(BuildContext context) {
    orderRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("orders");

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Material(
        child: Container(
          child: FutureBuilder(
              future: orderRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.size == 0) {
                    return Scaffold(
                      body: Material(
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: screenWidth,
                            child: Center(
                              child: Text(
                                "No orders to be fetched!", //When no orders will be there, KK
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    );
                  } else {
                    //  int currentValue = int.parse((snapshot.data.docs[index].data()["quantity"]).toString());

                    //  return Text("Hello World!");

                    return SingleChildScrollView(
                      child: Container(
                        height: screenHeight,
                        child: ListView.builder(
                            //    shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.size,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              QuerySnapshot itemsCart;
                              // snapshot.data.docs[index].reference.collection("items").get().then((snap) async{
                              //   itemsCart = snap;
                              //   print("itemsCart Size : " + itemsCart.size.toString());

                              return Container(
                                padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                                //  height: screenWidth/5,
                                width: screenWidth,
                                child: FutureBuilder(
                                    future: snapshot.data.docs[index].reference
                                        .collection("items")
                                        .get(),
                                    builder: (context, snapshot2) {
                                      if (snapshot2.hasData) {
                                        return Container(
                                          height: screenWidth / 3,
                                          //  width: screenWidth,
                                          child: ListView.builder(
                                              //  shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapshot2.data.size,
                                              itemBuilder: (context, index2) {
                                                print("Snapshot Size 2 : " +
                                                    snapshot2.data.size
                                                        .toString());
                                                return Container(
                                                  // child: Image.network(
                                                  //              "${snapshot2.data.docs[index2].data()["images"][0]}",
                                                  //              fit: BoxFit.fill,
                                                  //              height: screenWidth / 4.5,
                                                  //              width: screenWidth / 4.5,
                                                  //              scale: 1.0,
                                                  //            ),
                                                  //   height: screenWidth/5,
                                                  // width: screenWidth,
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Order #" +
                                                            (index + 1)
                                                                .toString()),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Image.network(
                                                                  "${snapshot2.data.docs[index2].data()["images"][0]}",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height:
                                                                      screenWidth /
                                                                          4.5,
                                                                  width:
                                                                      screenWidth /
                                                                          4.5,
                                                                  scale: 1.0,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      "${snapshot2.data.docs[index2].data()["Name"]}",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Raleway",
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "\u20B9 " +
                                                                  "${snapshot2.data.docs[index2].data()["price"]}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Raleway",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      19.0),
                                                            ),
                                                            Row(children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                // height: screenWidth/2,
                                                                width:
                                                                    screenWidth /
                                                                        5.5,
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount: snapshot2
                                                                      .data
                                                                      .docs[
                                                                          index2]
                                                                      .data()[
                                                                          "specifications"]
                                                                          [
                                                                          "customizable"]
                                                                      .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Container(
                                                                      child: Text(
                                                                          capitalize(
                                                                              "${snapshot2.data.docs[index2].data()["specifications"]["customizable"].keys.elementAt(index)}")),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                //  height: screenWidth/2,
                                                                width:
                                                                    screenWidth /
                                                                        5.5,
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount: snapshot2
                                                                      .data
                                                                      .docs[
                                                                          index2]
                                                                      .data()[
                                                                          "specifications"]
                                                                          [
                                                                          "customizable"]
                                                                      .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Container(
                                                                      child: Text(
                                                                          capitalize(
                                                                              "${snapshot2.data.docs[index2].data()["specifications"]["customizable"].values.elementAt(index)}")),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ])
                                                          ],
                                                        ),
                                                      ]),
                                                );
                                              }),
                                        );
                                      } else if (snapshot2.hasError) {
                                        return Text("${snapshot2.error}");
                                      }

                                      return Center(
                                          child: CircularProgressIndicator());
                                    }),
                              );
                            }),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}

dynamic fetchLength(CollectionReference cR) async {
  int num = await cR.snapshots().length;
  return num;
}
