import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgj/Bamal/pages/AddressSelector.dart';
import 'package:sgj/TopBar/SideDrawer.dart';
import 'package:sgj/components/Search/CloudFirestoreSearch.dart';
import 'package:strings/strings.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';

class Bag extends StatefulWidget {
  static User user = FirebaseAuth.instance.currentUser;
  static List<DocumentReference> checkoutList = new List<DocumentReference>();

  @override
  _BagState createState() => _BagState();
}

class _BagState extends State<Bag> {
  var cartLength = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    CollectionReference cartItems = FirebaseFirestore.instance
        .collection("users")
        .doc(Bag.user.uid)
        .collection("cart");
    Future<void> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await cartItems.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      setState(() {
        cartLength = allData.length;
      });
    }

    return Scaffold(
      persistentFooterButtons: [
        Container(
          width: screenWidth,
          height: screenWidth / 8,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              // alignment: Alignment.center,
              //  color: Color.fromRGBO(255, 92, 0, 1),
              height: screenWidth / 8,
              width: screenWidth / 2.2,
              child: ElevatedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.resolveWith<BorderSide>(
                      (Set<MaterialState> states) {
                    return BorderSide(
                        color: Color.fromRGBO(255, 92, 0, 1), width: 1.0);
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.white;
                  }),
                ),
                onPressed: () async {
                  //  if(isAdded == false)
                  // DocumentReference doc = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("cart").add(productData);
                  // FirebaseFirestore.instance
                  //     .collection("users")
                  //     .doc(user.uid)
                  //     .collection("cart")
                  //     .doc(doc.id)
                  //     .update({
                  //   'quantity' : '1',
                  //   'price' : NameInfo.finalPrice,
                  //   //     'time' : FieldValue.serverTimestamp,
                  //   's pecifications.customizable': Specs.customizable,
                  //   'specifications.size' : Specs.size
                  //   });
                  //      isAdded = true;

                  QuerySnapshot tempOrders = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(Bag.user.uid)
                      .collection("temporders")
                      .get();
                  getData();

                  int num = tempOrders.size + 1;
                  String docName = "Order" + "$num";
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(Bag.user.uid)
                      .collection("temporders")
                      .doc(docName)
                      .set({});
                  //   DocumentReference cRef = await doc.collection("Order"+ "$num").add(productData);

                  for (int i = 0; i < Bag.checkoutList.length; i++) {
                    DocumentSnapshot product =
                        await Bag.checkoutList.elementAt(i).get();
                    print('jujj');
                    print(i);
                    Map<String, dynamic> productData = product.data();
                    // QuerySnapshot tempOrders = await FirebaseFirestore.instance.collection("users").doc(Bag.user.uid).collection("temporders").get();
                    // int num = tempOrders.size;
                    // DocumentReference doc = await FirebaseFirestore.instance.collection("users").doc(Bag.user.uid).collection("temporders").doc();
                    // DocumentReference cRef = await FirebaseFirestore.instance.collection("users").doc(Bag.user.uid).collection("temporders").doc(docName).collection("items").add(productData);
                    //     doc.update(
                    //   {
                    //     'payment' : false
                    //   }
                    // );
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(Bag.user.uid)
                        .collection("cart")
                        .doc(Bag.checkoutList.elementAt(i).id)
                        .delete();
                  }
                  // Checkout with selected item , code improved to select,KK
                  Bag.checkoutList.clear();
                  if (cartLength != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Material(child: AddressSelector())));
                  }
                },
                child: Container(
                    //  alignment: Alignment.center,
                    child: Center(
                        child: Text(
                  "CHECKOUT" + " " + "WITH SELECTED ITEMS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Color.fromRGBO(255, 92, 0, 1),
                      fontSize: 12),
                ))),
              ),
            ),
            Container(
              height: screenWidth / 8,
              width: screenWidth / 2.2,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Color.fromRGBO(255, 92, 0, 1);
                  }),
                ),
                onPressed: () async {
                  cartItems.get().then((docQuerySnapshot) async {
                    List<QueryDocumentSnapshot> listDocs =
                        docQuerySnapshot.docs;
                    for (var i = 0; i < listDocs.length; i++)
                      Bag.checkoutList.add(listDocs[i].reference);
                  });

                  QuerySnapshot tempOrders = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(Bag.user.uid)
                      .collection("temporders")
                      .get();
                  print(Bag.user.uid);
                  //   print(tempOrders.size);
                  int num = tempOrders.size + 1;
                  String docName = "Order" + "$num";
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(Bag.user.uid)
                      .collection("temporders")
                      .doc(docName)
                      .set({});
                  //   DocumentReference cRef = await doc.collection("Order"+ "$num").add(productData);
                  getData();

                  for (int i = 1; i < Bag.checkoutList.length; i++) {
                    DocumentSnapshot product =
                        await Bag.checkoutList.elementAt(i).get();
                    Map<String, dynamic> productData = product.data();
                    // QuerySnapshot tempOrders = await FirebaseFirestore.instance.collection("users").doc(Bag.user.uid).collection("temporders").get();
                    // int num = tempOrders.size;
                    // DocumentReference doc = await FirebaseFirestore.instance.collection("users").doc(Bag.user.uid).collection("temporders").doc();
                    DocumentReference cRef = await FirebaseFirestore.instance
                        .collection("users")
                        .doc(Bag.user.uid)
                        .collection("temporders")
                        .doc(docName)
                        .collection("items")
                        .add(productData);
                    //     doc.update(
                    //   {
                    //     'payment' : false
                    //   }
                    // );
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(Bag.user.uid)
                        .collection("cart")
                        .doc(Bag.checkoutList.elementAt(i).id)
                        .delete();
                  }
                  // checkout with all items, code change to select,
                  Bag.checkoutList.clear();
                  if (cartLength != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Material(child: AddressSelector())));
                  }
                },
                child: Container(
                    child: Center(
                        child: Text(
                  "CHECKOUT WITH ALL ITEMS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Raleway',
                  ),
                ))),
              ),
            )
          ]),
        ),
      ],
      drawer: SideDrawer(),
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "Cart",
            style: TextStyle(color: Color(0xFF0B0086), fontFamily: 'Raleway'),
          ),
          titleSpacing: 1.0,
          // leading: IconButton(
          //   //  padding : EdgeInsets.only(left : 1.0, right : 1.0)  ,
          //     icon: Icon(Icons.dehaze_sharp,
          //         color: Colors.black),
          // ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return CloudFirestoreSearch();
                }));
              },
            ),
          ]),
      body: Material(
        child: SingleChildScrollView(
          child: Container(
              child: FutureBuilder(
                  future: cartItems.get(),
                  builder: (BuildContext context, snapshot) {
                    // if (snapshot.hasData) {
                    //   bool val = false;
                    //   return Container(
                    //     //   height: screenWidth,
                    //     child: ListView.builder(
                    //         shrinkWrap: true,
                    //         physics: NeverScrollableScrollPhysics(),
                    //         itemCount: snapshot.data.size,
                    //         itemBuilder: (context, index) {
                    //           print(snapshot.data.docs[index].data()["images"]
                    //               [0]);
                    //           return CheckBoxItem(
                    //             snapshot: snapshot,
                    //             screenWidth: screenWidth,
                    //             screenHeight: screenHeight,
                    //             index: index,
                    //             update: () async {
                    //               setState(() {});
                    //             },
                    //           );
                    //         }),
                    //   );

                    if (snapshot.hasData) {
                      return Container(
                        //   height: screenWidth,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.size,
                            itemBuilder: (context, index) {
                              print(snapshot.data.docs[index].data()["images"]
                                  [0]);
                              return CheckBoxItem(
                                snapshot: snapshot,
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                index: index,
                                update: () async {
                                  setState(() {});
                                },
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (cartLength == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text(
                          "No result",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  })),
        ),
      ),
    );
  }
}

class CheckBoxItem extends StatefulWidget {
  CheckBoxItem(
      {@required this.snapshot,
      @required this.screenWidth,
      @required this.screenHeight,
      @required this.index,
      @required this.update});

  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;
  final int index;
  final Function update;

  @override
  _CheckBoxItemState createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  bool val = false;
  ProgressDialog progressDialog;

//  int currentValue;
  void initState() {
    progressDialog = ProgressDialog(barrierDismissible: false);
    //  currentValue = int.parse(widget.snapshot.data.docs[widget.index].data()["quantity"].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      //  int currentValue = int.parse((widget.snapshot.data.docs[widget.index].data()["quantity"]).toString());
      return Container(
          padding: EdgeInsets.all(8.0),
          child: CheckboxListTile(
            contentPadding: EdgeInsets.all(0),
            controlAffinity: ListTileControlAffinity.leading,
            value: val,
            onChanged: (value) {
              print(widget.snapshot.data.docs[widget.index].reference);
              setState(() {
                if (value == true)
                  Bag.checkoutList
                      .add(widget.snapshot.data.docs[widget.index].reference);
                else
                  Bag.checkoutList.remove(
                      widget.snapshot.data.docs[widget.index].reference);
                val = value;
              });
            },
            // tristate: false,
            title: Container(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "${widget.snapshot.data.docs[widget.index].data()["images"][0]}",
                          fit: BoxFit.fill,
                          height: widget.screenWidth / 4.5,
                          width: widget.screenWidth / 4.5,
                          scale: 1.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            child: Text(
                              "${widget.snapshot.data.docs[widget.index].data()["Name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\u20B9 " +
                          "${widget.snapshot.data.docs[widget.index].data()["price"]}",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0),
                    ),
                    Row(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        // height: widget.screenWidth/2,
                        width: widget.screenWidth / 5.5,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.snapshot.data.docs[widget.index]
                              .data()["specifications"]["customizable"]
                              .length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              child: Text(capitalize(
                                  "${widget.snapshot.data.docs[widget.index].data()["specifications"]["customizable"].keys.elementAt(index)}")),
                            );
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        //  height: widget.screenWidth/2,
                        width: widget.screenWidth / 5.5,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.snapshot.data.docs[widget.index]
                              .data()["specifications"]["customizable"]
                              .length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Text(capitalize(
                                  "${widget.snapshot.data.docs[widget.index].data()["specifications"]["customizable"].values.elementAt(index)}")),
                            );
                          },
                        ),
                      ),
                    ])
                  ],
                ),
                Column(children: [
                  DropDown(
                      snapshot: widget.snapshot,
                      index: widget.index,
                      screenWidth: widget.screenWidth),
                  Align(
                    child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        //  size: .5,
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                insetPadding: EdgeInsets.fromLTRB(
                                    widget.screenWidth / 3,
                                    widget.screenHeight / 2.5,
                                    widget.screenWidth / 3,
                                    widget.screenHeight / 2.5),
                                child: Container(
                                    child: Center(
                                        child:
                                            new CircularProgressIndicator())),
                              );
                            });
                        // progressDialog.showMaterial(layout: MaterialProgressDialogLayout.overlayCircularProgressIndicator);
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(Bag.user.uid)
                            .collection("cart")
                            .doc(widget
                                .snapshot.data.docs[widget.index].reference.id)
                            .delete();
                        await widget.update();
                        Navigator.of(context, rootNavigator: true).pop();
                        //  progressDialog.dismiss();
                      },
                    ),
                    alignment: Alignment.topRight,
                  )
                ]),
              ]),
            ),
          ));
    } else if (widget.snapshot.hasError) {
      return Text("${widget.snapshot.error}");
    }

    return Center(child: CircularProgressIndicator());
  }
}

class DropDown extends StatefulWidget {
  DropDown(
      {@required this.snapshot,
      @required this.index,
      @required this.screenWidth});

  final AsyncSnapshot snapshot;
  final int index;
  final double screenWidth;
  final TextEditingController textController = new TextEditingController();

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int currentValue;

  void initState() {
    currentValue = int.parse(
        widget.snapshot.data.docs[widget.index].data()["quantity"].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.textController.text = currentValue.toString();
    return Container(
        width: widget.screenWidth / 6,
        // height: widget.screenWidth/8,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: widget.screenWidth / 14,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  //padding: EdgeInsets.all(0.0),
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  controller: widget.textController,
                  maxLines: 1,
                  maxLength: 2,

                  // inputFormatters: [textDirection],
                  textDirection: TextDirection.rtl,
                  //     validator: (value){
                  //       if(int.parse(value) < 1 )
                  //         return 'Quantity cannot be less than 1';
                  //    //   else if(value.isEmpty) {s
                  //   //      widget.textController.text = currentValue.toString();
                  //   //    return 'Quantity cannot be empty';
                  // //    }
                  //   //  return null;
                  //
                  //     },
                  onChanged: (value) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(Bag.user.uid)
                        .collection("cart")
                        .doc(widget
                            .snapshot.data.docs[widget.index].reference.id)
                        .update({
                      'quantity': int.parse(value),
                    });
                    currentValue = int.parse(value);
                    //   setState(() {
                    //   widget.textController.text = value;
                    //  });
                  },
                  //   onSaved: ,
                  //    onFieldSubmitted: (value){
                  //      FirebaseFirestore.instance
                  //          .collection("users")
                  //          .doc(Bag.user.uid)
                  //          .collection("cart")
                  //          .doc(widget.snapshot.data.docs[widget.index].reference.id)
                  //          .update({
                  //        'quantity' : int.parse(value),
                  //      });
                  //   //   setState(() {
                  //      //  widget.textController.text = value;
                  // //     });
                  //    },
                ),
              ),
              Container(
                //   padding: EdgeInsets.all(0.0),
                width: widget.screenWidth / 12,

                child: PopupMenuButton<int>(
                  padding: EdgeInsets.all(0.0),
                  icon: Icon(Icons.arrow_drop_down_sharp),
                  // validator: (value){
                  //
                  // },
                  itemBuilder: (context) {
                    return <int>[1, 2, 3, 4, 5]
                        .map<PopupMenuItem<int>>((int value) {
                      return PopupMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList();
                  },
                  onSelected: (value) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(Bag.user.uid)
                        .collection("cart")
                        .doc(widget
                            .snapshot.data.docs[widget.index].reference.id)
                        .update({
                      'quantity': value,
                    });
                    setState(() {
                      currentValue = value;
                    });
                  },
                  //  value: currentValue,
                ),
              ),
            ])
        // child: SizeButton(minSize: widget.snapshot.data.docs[widget.index].data()["specifications"]["size"]["min"], maxSize: widget.snapshot.data.docs[widget.index].data()["specifications"]["size"]["max"],currentSize: widget.snapshot.data.docs[widget.index].data()["specifications"]["customizable"]["size"],update: (var value, String name) {
        //   print("I ran");
        //   setState(() {
        //     if(name.compareTo("size") == 0)
        //       widget.snapshot.data.docs[widget.index].data()["specifications"]["customizable"]["size"] = value;
        //   });
        // }
        //   ),
        );
  }
}

// CollectionReference getCartItems (User user) {
//    CollectionReference cartItems =  FirebaseFirestore.instance.collection("users").doc(user.uid).collection("cart");
//    return cartItems;
// }
