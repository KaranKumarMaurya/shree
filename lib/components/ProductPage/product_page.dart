import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgj/Bamal/pages/AddressSelector.dart';
import 'package:sgj/components/ProductPage/SizeButton.dart';
import 'package:sgj/components/Search/CloudFirestoreSearch.dart';
import 'package:strings/strings.dart';
import 'product_carousel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgj/TopBar/SideDrawer.dart';
import 'package:sgj/components/Bag/Bag.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPage extends StatefulWidget {
  ProductPage({@required this.productKey});

  final String productKey;
  static var screenHeight;
  static var screenWidth;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isAdded = false;
  ProgressDialog progressDialog = ProgressDialog(barrierDismissible: false);

  @override
  Widget build(BuildContext context) {
    ProductPage.screenHeight = MediaQuery.of(context).size.height;

    ProductPage.screenWidth = MediaQuery.of(context).size.width;
    print(widget.productKey);
    User user = FirebaseAuth.instance.currentUser;
    //final DocumentReference _prodRef = FirebaseFirestore.instance.collection("Products").doc(productKey);
    DocumentReference _proRef = docReference(widget.productKey);
    Future<DocumentSnapshot> pro = _proRef.get();
    Map<String, dynamic> productData;

    // List<Image> imageslist = imagelist(pro);
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "Shree Ganga Jewellers",
            style: TextStyle(
                color: Color(0xFF0B0086),
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: 'Raleway'),
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
            IconButton(
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Bag()));
              },
            )
          ]),
      persistentFooterButtons: [
        Container(
          width: ProductPage.screenWidth,
          height: ProductPage.screenWidth / 8,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              //  color: Color.fromRGBO(255, 92, 0, 1),
              height: ProductPage.screenWidth / 8,
              width: ProductPage.screenWidth / 2.2,
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
                  isAdded = true;
                  setState(() {});
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          insetPadding: EdgeInsets.fromLTRB(
                              ProductPage.screenWidth / 3,
                              ProductPage.screenHeight / 2.5,
                              ProductPage.screenWidth / 3,
                              ProductPage.screenHeight / 2.5),
                          child: Container(
                              child: Center(
                                  child: new CircularProgressIndicator())),
                        );
                      });
                  //  if(isAdded == false)
                  DocumentReference doc = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .collection("cart")
                      .add(productData);
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .collection("cart")
                      .doc(doc.id)
                      .update({
                    'quantity': '1',
                    'price': NameInfo.finalPrice,
                    //     'time' : FieldValue.serverTimestamp,
                    'specifications.customizable': Specs.customizable,
                  });
                  //    progressDialog.dismiss();
                  Navigator.of(context, rootNavigator: true).pop();

                  await Fluttertoast.showToast(
                    msg: "Added to Cart",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Color.fromRGBO(255, 92, 0, 1),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },

                child: isAdded
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Bag()));
                        },
                        // Added to cart change to go to cart, KK
                        child: Text(
                          "Go To Cart",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontFamily: 'Raleway'),
                        ),
                      )
                    : Text(
                        "Add to cart",
                        style:
                            TextStyle(color: Colors.red, fontFamily: 'Raleway'),
                      ),
                // await FirebaseFirestore.instance
                //     .collection("users")
                //     .doc(user.uid)
                //     .collection("cart")
                //     .doc(doc.id)
                //     .update({
                //   'specifications.customizable.size' : Specs.size,
                // });

                // await FirebaseFirestore.instance
                //     .collection("users")
                //     .doc(user.uid)
                //     .collection("cart")
                //     .doc(doc.id)
                //     .update({
                //   'specifications.size' : FieldValue.delete(),
                // });

                // child: Container(
                //     child: Center(
                //         child: isAdded?TextButton(onPressed: (){
                //           Navigator.push(context, MaterialPageRoute(builder: (context)=>Bag()));
                //         }, child: Text("Go To Cart",
                //            style: TextStyle(
                //              color: Colors.deepPurple,
                //              fontSize: 18
                //            ),
                //         ),)
                //             :Text(
                //          "ADD TO CART",
                //           style: TextStyle(
                //               color: Color.fromRGBO(255, 92, 0, 1)
                //           ),
                //         )
                //     )
                // ),
              ),
            ),
            Container(
              height: ProductPage.screenWidth / 8,
              width: ProductPage.screenWidth / 2.2,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Color.fromRGBO(255, 92, 0, 1);
                  }),
                ),
                onPressed: () async {
                  //  if(isAdded == false)
                  QuerySnapshot tempOrders = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .collection("temporders")
                      .get();

                  int num = tempOrders.size + 1;
                  String docName = "Order" + "$num";
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .collection("temporders")
                      .doc(docName)
                      .set({});
                  DocumentReference cRef = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(Bag.user.uid)
                      .collection("temporders")
                      .doc(docName)
                      .collection("items")
                      .add(productData);
                  //  DocumentReference doc = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("temporders").add(productData);
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .collection("temporders")
                      .doc(docName)
                      .collection("items")
                      .doc(cRef.id)
                      .update({
                    'quantity': '1',
                    'price': NameInfo.finalPrice,
                    //     'time' : FieldValue.serverTimestamp,
                    'specifications.customizable': Specs.customizable,
                    //   'specifications.customizable.size' : Specs.size
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Material(child: AddressSelector())));
                  //      isAdded = true;
                },
                child: Container(child: Center(child: Text("BUY NOW"))),
              ),
            )
          ]),
        ),
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          child: InkWell(
            //  onTap: (){Navigator.pop(context);},
            child: Container(
              child: FutureBuilder(
                future: pro,
                builder: (context, snapshot) {
                  print("Replicated Products");
                  if (snapshot.hasData) {
                    productData = snapshot.data.data();
                    print("Reached If");
                    return Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Photos(
                              snapshot: snapshot,
                              screenHeight: ProductPage.screenHeight,
                              screenWidth: ProductPage.screenWidth),
                          NameInfo(
                              snapshot: snapshot,
                              screenHeight: ProductPage.screenHeight,
                              screenWidth: ProductPage.screenWidth),
                          Specs(
                              snapshot: snapshot,
                              screenHeight: ProductPage.screenHeight,
                              screenWidth: ProductPage.screenWidth),
                          About(
                              snapshot: snapshot,
                              screenHeight: ProductPage.screenHeight,
                              screenWidth: ProductPage.screenHeight),
                          ProductDetails(
                              snapshot: snapshot,
                              screenHeight: ProductPage.screenHeight,
                              screenWidth: ProductPage.screenHeight),
                          RetExchange(
                              snapshot: snapshot,
                              screenHeight: ProductPage.screenHeight,
                              screenWidth: ProductPage.screenHeight),
                          CertifiedBy(
                              snapshot: snapshot,
                              screenHeight: ProductPage.screenHeight,
                              screenWidth: ProductPage.screenHeight),
                          //Product Display Carousel
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Complete the Look",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Raleway'),
                                      ),
                                      ProductDisplayCarousel()
                                    ])),
                          ),
                          //Need help to decide
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          "Still confused to buy?",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Raleway'),
                                        ),
                                      ),
                                      Text(
                                          "Connect with our fashion experts, stylists and certified gemologists to answer your questions and concerns."),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            launchWhatsApp(
                                                phone: "+918126474813",
                                                message: "Hi");
                                          },
                                          child: Container(
                                            child: SvgPicture.asset(
                                                "assets/whatsapp.svg",
                                                fit: BoxFit.fill,
                                                height:
                                                    ProductPage.screenWidth / 7,
                                                width: ProductPage.screenWidth /
                                                    7),
                                          ),
                                        ),
                                      )
                                    ])),
                          )
                        ]);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Photos extends StatefulWidget {
  Photos(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth});
  // final String productKey;
  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;

  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  // _ProductPageState({Key : key}) : super(key:key);
  // List<String> imageslist = [];

  int initPage = 0;
  CarouselController jump = CarouselController();
  void initState() {
    //   DocumentReference _proRef = docReference(widget.productKey);
    //  widget.pro = _proRef.get();
    super.initState();
  }

  int borderIndex = 0;
  @override
  Widget build(BuildContext context) {
    //final DocumentReference _prodRef = FirebaseFirestore.instance.collection("Products").doc(productKey);
    // DocumentReference _proRef = docReference(widget.productKey);
    //  Future<DocumentSnapshot> pro = _proRef.get();
    //  List<Image> imageslist = new List();
    if (widget.snapshot.hasData) {
      Map<String, dynamic> lsit = widget.snapshot.data.data();
      // final CollectionReference _testRef = FirebaseFirestore.instance.collection("test");
      // _testRef.add(lsit);
      // print("Added"); //Testing Code Ends
      int length = lsit["images"].length;
      return Container(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
              padding: EdgeInsets.only(bottom: 2.0),
              child: CarouselSlider.builder(
                itemCount: length,
                carouselController: jump,
                options: CarouselOptions(
                    height: 200.0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    //     initialPage: initPage
                    onPageChanged: (index, reason) {
                      setState(() {
                        borderIndex = index;
                      });
                    }),
                itemBuilder: (context, index, currentIndex) {
                  return Container(
                      width: widget.screenWidth,
                      height: widget.screenHeight / 3,
                      child: Image.network("${lsit["images"][index]}"));
                },
              ),
            ),
            Container(
              //  alignment: Alignment.center,
              height: widget.screenWidth / 7,
              child: ListView.builder(
                  padding: EdgeInsets.all(2.0),
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: length,
                  itemBuilder: (BuildContext context, int index) {
                    //      return Builder(builder: (context, index) {
                    if (index == borderIndex) {
                      return InkWell(
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3.0, color: Colors.blue[900])),
                            width: widget.screenWidth / 7,
                            child: Image.network(
                              "${lsit["images"][index]}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            borderIndex = index;
                            jump.jumpToPage(index);
                            print(index);
                          });
                        },
                      );
                    } else {
                      return InkWell(
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0, color: Colors.transparent)),
                            width: widget.screenWidth / 7,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black)),
                              child: Image.network(
                                "${lsit["images"][index]}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            borderIndex = index;
                            jump.jumpToPage(index);
                            print(index);
                          });
                        },
                      );
                    }
                  }
                  //     );

                  //  ).toList(),

                  ),
            )
          ])
          //    }).toList(),

          //        );
          //print(lsit["images"][0]);
          );
    } else if (widget.snapshot.hasError) {
      return Text("${widget.snapshot.error}");
    }

    return CircularProgressIndicator(); //wrap inside sized box to resize
  }
}

class NameInfo extends StatefulWidget {
  NameInfo(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth});
  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;
  static int finalPrice;

  @override
  _NameInfoState createState() => _NameInfoState();
}

class _NameInfoState extends State<NameInfo> {
  var data;
  void initState() {
    // TODO: implement initState
    super.initState();
    gold_price();
  }

  gold_price() async {
    Uri apiUrl = Uri.parse("https://www.goldapi.io/api/XAU/INR");
    final http.Response response =
        await http.get(apiUrl, headers: <String, String>{
      'x-access-token': 'goldapi-b3cme2ukov6n85p-io',
      'Content-Type': 'application/json'
    });
    // print(response.body);
    data = jsonDecode(response.body);
    print(data['price']);
    // var ab = response.body;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      print("Photos Successful");
      int price_ = data['price'] != null ? (data['price']).round() : 0;
      //     int price = widget.snapshot.data.data()["price"];
      int discount = widget.snapshot.data.data()["discount"];
      int weight = widget.snapshot.data.data()["details"]["weight"] != null
          ? widget.snapshot.data.data()["details"]["weight"]
          : 0;
      ;
      //  print("$weight");
      double carat = widget.snapshot.data.data()["specifications"]
                  ["customizable"]["carat"] !=
              22
          ? 0.75
          : 0.917;
      int making =
          widget.snapshot.data.data()["details"]["making charges"] != null
              ? widget.snapshot.data.data()["details"]["making charges"]
              : 0;
      NameInfo.finalPrice =
          ((((price_ * (weight / 28.3495)) * carat) + making) *
                  (100 - discount) /
                  100)
              .ceil();
      int price = (((price_ * (weight / 28.3495)) * carat) + making).ceil();
      //print("${NameInfo.finalPrice}");

      return Container(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //    padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "${widget.snapshot.data.data()["Name"]}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: widget.screenWidth / 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Raleway'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 2.0),
                  child: Text(
                    "From ${widget.snapshot.data.data()["Category"]}",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(children: [
                    Container(
                      //   padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        '\u20B9' + "${NameInfo.finalPrice}",
                        style: TextStyle(
                            fontSize: widget.screenWidth / 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                    SizedBox(
                      width: widget.screenWidth / 25,
                    ),
                    Container(
                      child: Text(
                        '\u20B9' + "$price",
                        style: TextStyle(
                           fontFamily: 'Raleway',
                          // decorationStyle: TextDecorationStyle.double,
                          decoration: TextDecoration.lineThrough,
                          fontSize: widget.screenWidth / 20,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.screenWidth / 35, left: 2.0, right: 3.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Buy now and get additional $discount% off",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 17.0,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                        // Container(
                        //   child: Text("More Offers",
                        //     style: TextStyle(
                        //       color: Colors.indigo[600],
                        //       fontSize: 17.0
                        //     ),
                        //   ),
                        // )
                      ]),
                ),
              ],
            ),
          ),
        ]),
      );
    } else if (widget.snapshot.hasError) {
      return Text("${widget.snapshot.error}");
    }

    return CircularProgressIndicator();
  }
}

class Specs extends StatefulWidget {
  Specs(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth});
  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;
  static List<int> isSelected;
  // static var size;
  static const double specsPadding = 5.0;
  static Map<String, dynamic> customizable;
  Map<String, dynamic> specsMap;
  // final VoidCallback fromAnother;
  @override
  _SpecsState createState() => _SpecsState();
}

class _SpecsState extends State<Specs> {
  var carat;
  var maxSize;
  var minSize;
  var colour;
  var diamond;
  var size;
  // static var size;
  var greycolour;
  var type;
  //   type = capitalize(type);
  var count;

  @override
  void initState() {
    Specs.isSelected = new List<int>.filled(
        (widget.snapshot.data.data()["specifications"]["customizable"]).length,
        0,
        growable: true);
    carat = (widget.snapshot.data.data()["specifications"]["customizable"]
        ["carat"])[0];
    colour = (widget.snapshot.data.data()["specifications"]["customizable"]
        ["colour"])[0];
    diamond = capitalize(
        (widget.snapshot.data.data()["specifications"]["diamond"]).toString());
    //  double specsPadding = 5.0;
    size = widget.snapshot.data.data()["specifications"]["size"]["default"];
    maxSize = widget.snapshot.data.data()["specifications"]["size"]["max"];
    minSize = widget.snapshot.data.data()["specifications"]["size"]["min"];
    greycolour = 200;
    type = widget.snapshot.data.data()["specifications"]["type"];
    //   type = capitalize(type);
    count = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      Iterable customizableValues = [carat, colour];
      widget.specsMap =
          widget.snapshot.data.data()["specifications"]["customizable"];
      Specs.customizable = Map.fromIterables(
          (widget.specsMap.keys).toList().reversed, customizableValues);
      Specs.customizable.addAll({'size': size});

      print("Nameinfo Successful");
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      top: 15.0, right: 15.0, left: 15.0, bottom: 10.0),
                  //   constraints: BoxConstraints(
                  //       minWidth: widget.screenWidth
                  //       ),

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //  padding: EdgeInsets.all(15.0),
                          color: Colors.white,
                          child: Text(
                            "Design Specifications",
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Specs.specsPadding,
                                  right: 38.0,
                                  left: 5.0),
                              child: Container(
                                height: widget.screenHeight / 8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(capitalize("$type") + " and Ct."),
                                    Text("Diamond"),
                                    Text("Size")
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Specs.specsPadding),
                              child: Container(
                                height: widget.screenHeight / 8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (type == 'gold')
                                      Text(
                                        "$carat Ct " +
                                            capitalize("$colour") +
                                            " " +
                                            capitalize("$type"),
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            backgroundColor:
                                                Colors.grey[greycolour]),
                                      )
                                    else
                                      Text(
                                        "$carat Ct" + " " + capitalize("$type"),
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            backgroundColor:
                                                Colors.grey[greycolour]),
                                      ),
                                    Text(
                                      "$diamond",
                                      style: TextStyle(
                                          backgroundColor:
                                              Colors.grey[greycolour],
                                          fontFamily: 'Raleway'),
                                    ),
                                    Text(
                                      "$size",
                                      style: TextStyle(
                                          backgroundColor:
                                              Colors.grey[greycolour],
                                          fontFamily: 'Raleway'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: InkWell(
                              child: RaisedButton(
                                textColor: Colors.lightBlue[900],
                                child: Text("Customize Design"),
                                onPressed: () {
                                  showBottomSheet(
                                      backgroundColor:
                                          Colors.black.withOpacity(0.5),
                                      context: context,
                                      builder: (context) {
                                        return CustomizeDesign(
                                            currSize: size,
                                            snapshot: widget.snapshot,
                                            isSelected: Specs.isSelected,
                                            maxSize: maxSize,
                                            minSize: minSize,
                                            update: (var value, String name) {
                                              print("I ran");
                                              setState(() {
                                                if (name.compareTo("carat") ==
                                                    0)
                                                  carat = value;
                                                else if (name
                                                        .compareTo("colour") ==
                                                    0)
                                                  colour = value;
                                                else if (name
                                                        .compareTo("size") ==
                                                    0) if (value <=
                                                        maxSize &&
                                                    value >= minSize)
                                                  size = value;
                                              });

                                              //  Specs.customizable = Map.fromIterables(widget.specsMap.keys, customizableValues);
                                            });
                                      });
                                },
                                color: Colors.white,
                                shape: ContinuousRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blueGrey, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]) //Inside Card
                  ),
            )
          ],
        ),
      );
    } else if (widget.snapshot.hasError) {
      return Text("${widget.snapshot.error}");
    }

    return CircularProgressIndicator();
  }
}

class CustomizeDesign extends StatefulWidget {
  CustomizeDesign(
      {@required this.currSize,
      @required this.snapshot,
      @required this.update,
      @required this.isSelected,
      @required this.minSize,
      @required this.maxSize});

  final Function update;
  final AsyncSnapshot snapshot;
  final List<int> isSelected;
  final int maxSize;
  final int minSize;
  final int currSize;

  @override
  _CustomizeDesignState createState() => _CustomizeDesignState();
}

class _CustomizeDesignState extends State<CustomizeDesign> {
  bool vis;
  int size;
  void initState() {
    size = widget.currSize;
    vis = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (widget.snapshot.hasData) {
      //  print(Specs.size.toString());
      print("DesignSpecs Successful");
      final int price = widget.snapshot.data.data()["price"];
      final int discount = widget.snapshot.data.data()["discount"];
      final int finalPrice =
          (int.parse("${NameInfo.finalPrice}") * (100 - discount)) ~/ 100;
      var count = 0;
      return Visibility(
        visible: vis,
        child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          InkWell(
            onTap: () {
              setState(() {
                vis = false;
                Navigator.pop(context);
              });
            },
            child: Container(
              height: screenHeight,
              // color: Colors.white.withOpacity(0),
              // color: Colors.black,
            ),
          ),
          Container(
            color: Colors.white,
            //    padding: EdgeInsets.all(8.0),
            height: screenHeight / 2,
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text("Customize Design"),
                // color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //row of columns for Price and Delivery By
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("Necklace Price"), Text("Delivery By")],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\u20B9' + "$finalPrice"),
                        Text("Day, Month, Date")
                      ],
                    )
                  ],
                ),
              ),
              Container(
                // height: screenHeight/2,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: (widget.snapshot.data.data()["specifications"]
                          ["customizable"])
                      .length,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, int indexUpper) {
                    print(count);
                    count++;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(width: 1.0, color: Colors.grey[400]),
                          bottom:
                              BorderSide(width: 1.0, color: Colors.grey[400]),
                        )),
                        child: Row(children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.grey[400]))),
                            padding: EdgeInsets.only(right: screenWidth / 30),
                            height: screenWidth / 7,
                            width: screenWidth / 4,
                            alignment: Alignment.center,
                            child: Text(
                              (capitalize("${widget.snapshot.data.data()["specifications"]["type"]}") +
                                      " " +
                                      capitalize(
                                          "${(widget.snapshot.data.data()["specifications"]["customizable"]).keys.elementAt(indexUpper)}"))
                                  .toUpperCase(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          ButtonRowBuilder(
                            snapshot: widget.snapshot,
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            indexUpper: indexUpper,
                            update: widget.update,
                            isSelected: widget.isSelected.elementAt(indexUpper),
                          )
                        ]),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[400]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[400]),
                    )),
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Colors.grey[400]))),
                        padding: EdgeInsets.only(right: screenWidth / 30),
                        height: screenWidth / 7,
                        width: screenWidth / 4,
                        alignment: Alignment.centerRight,
                        child: Text(
                          (("Size").toUpperCase()),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                          //  width: ProductPage.screenWidth/18,
                          //  height: ProductPage.screenWidth/18,
                          child: SizeButton(
                        update: widget.update,
                        minSize: widget.minSize,
                        maxSize: widget.maxSize,
                        currSize: size,
                      ))
                    ]),
                  ))
            ]),
          )
        ]),
      );
    } else if (widget.snapshot.hasError) {
      return Container(child: Text("${widget.snapshot.error}"));
    }
    return CircularProgressIndicator();
  }
}

class ButtonRowBuilder extends StatefulWidget {
  ButtonRowBuilder(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth,
      @required this.indexUpper,
      @required this.update,
      @required this.isSelected});
  final Function update;
  final AsyncSnapshot snapshot;
  final double screenHeight;
  final double screenWidth;
  // final ButtonIdentity id;
  final int indexUpper;
  final int isSelected;
  @override
  _ButtonRowBuilderState createState() => _ButtonRowBuilderState();
}

class _ButtonRowBuilderState extends State<ButtonRowBuilder> {
  int stateIsSelected;
  void initState() {
    super.initState();
    stateIsSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      return Expanded(
        child: Container(
          height: widget.screenWidth / 7,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ((widget.snapshot.data.data()["specifications"]
                            ["customizable"])
                        .values
                        .elementAt(widget.indexUpper))
                    .length,
                itemBuilder: (context, int index) {
                  var value = (widget.snapshot.data
                      .data()["specifications"]["customizable"]
                      .values
                      .elementAt(widget.indexUpper))[index];
                  var buttonColour = (stateIsSelected == index)
                      ? Color.fromRGBO(00, 48, 148, 1.0)
                      : Colors.white;
                  var textColour =
                      (stateIsSelected == index) ? Colors.white : Colors.black;
                  var borderColour = (stateIsSelected == index)
                      ? Color.fromRGBO(00, 48, 148, 1.0)
                      : Colors.grey[400];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      //   key: Key((counter++).toString()),
                      onPressed: () {
                        Specs.isSelected.removeAt(widget.indexUpper);
                        Specs.isSelected.insert(widget.indexUpper, index);
                        setState(() {
                          stateIsSelected = index;
                        });
                        widget.update(
                            value,
                            ((widget.snapshot.data.data()["specifications"]
                                        ["customizable"])
                                    .keys
                                    .elementAt(widget.indexUpper))
                                .toString());
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(widget.screenWidth / 30),
                          side: BorderSide(color: borderColour)),
                      color: buttonColour,
                      child: Container(
                        alignment: Alignment.center,
                        width: widget.screenWidth / 6,
                        height: widget.screenWidth / 7,
                        child: Text(
                          capitalize("$value"),
                          style: TextStyle(
                              color: textColour, fontFamily: 'Raleway'),
                        ),
                      ),
                    ),
                  );
                }),
          ]),
        ),
      );
    } else if (widget.snapshot.hasError) {
      return Text("${widget.snapshot.error}");
    }

    return CircularProgressIndicator();
  }
}

Key forStorage;
// class Buttons extends StatefulWidget {
//   Buttons({@required this.snapshot, @required this.screenHeight, @required this.screenWidth, @required this.index, @required this.indexUpper, this.id});
//   final AsyncSnapshot snapshot;
//   final double screenHeight;
//   final double screenWidth;
//   final ButtonIdentity id;
//   final int indexUpper, index;
//   @override
//   _ButtonsState createState() => _ButtonsState();
// }
//
// class _ButtonsState extends State<Buttons> {
//   var buttonColour = Colors.white;
//   var textColour = Colors.black;
// //  var buttonColour = Color.fromRGBO(00, 48, 148, 1.0);
//  // var textColour = Colors.white;
//   int counter = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: RaisedButton(
//         key: Key((counter++).toString()),
//         onPressed: (){
//           this.setState(() {
//             buttonColour =  Color.fromRGBO(00, 48, 148, 1.0);
//             textColour = Colors.white;
//           });
//         },
//         color:buttonColour,
//         child: Container(
//           alignment: Alignment.center,
//           width: widget.screenWidth/6 ,
//           height: widget.screenWidth/7,
//           child: Text(capitalize("${(widget.snapshot.data.data()["specifications"]["customizable"].values.elementAt(widget.indexUpper))[widget.index]}"),
//             style: TextStyle(color: textColour),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ButtonIdentity {
  bool isSelected;
  int group;
}

class About extends StatelessWidget {
  About(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth});

  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      print("CustomizeDesign Successful");
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      top: 15.0, right: 15.0, left: 15.0, bottom: 10.0),
                  //   constraints: BoxConstraints(
                  //       minWidth: widget.screenWidth
                  //       ),

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //  padding: EdgeInsets.all(15.0),
                          color: Colors.white,
                          child: Text(
                            "About",
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                          ),
                        ),
                        Container(
                            child: Text(
                          "${snapshot.data.data()["about"]}",
                          textAlign: TextAlign.justify,
                        ))
                      ]) //Inside Card
                  ),
            )
          ],
        ),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return CircularProgressIndicator();
  }
}

class ProductDetails extends StatelessWidget {
  ProductDetails(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth});

  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      print("About Successful");
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      top: 15.0, right: 15.0, left: 15.0, bottom: 10.0),
//   constraints: BoxConstraints(
//       minWidth: widget.screenWidth
//       ),

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
//  padding: EdgeInsets.all(15.0),
                          color: Colors.white,
                          child: Text(
                            "Design Specifications",
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                          ),
                        ),
                        Container(
                          height: screenHeight /
                              ((snapshot.data.data()["details"].keys.length) *
                                  5),
                          child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: Specs.specsPadding,
                                    right: 38.0,
                                    left: 5.0),
                                child: Container(
                                  //  height: screenHeight / 12,
                                  width: screenWidth / 7,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: snapshot.data
                                                .data()["details"]
                                                .keys
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    capitalize(
                                                        "${snapshot.data.data()["details"].keys.elementAt(index)}"),
                                                    style: TextStyle(
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ));
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: Specs.specsPadding),
                                child: Container(
                                  //   height: screenHeight / 12,
                                  width: screenWidth / 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(capitalize(
                                          "${snapshot.data.data()["details"].values.elementAt(0)}")),
                                      Text(capitalize(
                                          "${snapshot.data.data()["details"].values.elementAt(1)}" +
                                              "g")),
                                      // Expanded(
                                      //
                                      //   child: ListView.builder(
                                      //       itemCount: snapshot.data.data()["details"].keys.length,
                                      //       itemBuilder:
                                      //           (BuildContext context, int index){
                                      //         return Container(
                                      //          padding: EdgeInsets.all(8.0)   ,
                                      //         child: Text(capitalize("${snapshot.data.data()["details"].values.elementAt(1)}"+"g")));
                                      //       }),
                                      // )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]) //Inside Card
                  ),
            )
          ],
        ),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return CircularProgressIndicator();
  }
}

class RetExchange extends StatelessWidget {
  RetExchange(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth});

  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      print("ProductDetails Successful");
      return Container(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 15.0, right: 15.0, left: 15.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Return and Exchange Policies",
                        style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              width: screenWidth / 32,
                              height: screenWidth / 32,
                              child: SvgPicture.asset(
                                "assets/returnroundedicon.svg",
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 12.0, top: 16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "30 Day Return Policy",
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                        "100% Refund, no questions asked."),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              width: screenWidth / 32,
                              height: screenWidth / 32,
                              child: Icon(Icons.autorenew)),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 12.0, top: 30.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lifetime Exchange",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Raleway'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Text(
                                          "Get 90% of money back including making charges."),
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )));
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return CircularProgressIndicator();
  }
}

class CertifiedBy extends StatelessWidget {
  CertifiedBy(
      {@required this.snapshot,
      @required this.screenHeight,
      @required this.screenWidth});

  final AsyncSnapshot snapshot;
  final screenHeight;
  final screenWidth;
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      print("Ret Successful");
      return Container(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 15.0, right: 15.0, left: 15.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Certified By",
                        style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                      ),
                    ),
                    Image.asset("assets/CertifiedBy.png")
                  ],
                ),
              )));
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return CircularProgressIndicator();
  }
}

class AddToCart extends StatefulWidget {
  const AddToCart({Key key}) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        isAdded = true;
        setState(() {});
      },
      child: isAdded ? Text("Added") : Text("Add To Cart"),
    );
  }
}

// class MoreOffers extends StatefulWidget {
//       @override
//       _MoreOffersState createState() => _MoreOffersState();
//     }
//
//     class _MoreOffersState extends State<MoreOffers> {
//       @override
//       Widget build(BuildContext context) {
//         return Container();
//       }
//     }

DocumentReference docReference(String productref) {
  final DocumentReference _prodRef =
      FirebaseFirestore.instance.collection("Products").doc(productref);

  return _prodRef;
}

void launchWhatsApp({
  @required String phone,
  @required String message,
}) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    } else {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}
