import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDisplayCarousel extends StatefulWidget {
  @override
  _ProductDisplayCarouselState createState() => _ProductDisplayCarouselState();
}

class _ProductDisplayCarouselState extends State<ProductDisplayCarousel> {
  final CollectionReference _productRef = FirebaseFirestore.instance.collection("Products");
  Map data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gold_price();

  }

  gold_price() async{
    Uri apiUrl = Uri.parse("https://www.goldapi.io/api/XAU/INR");
    final http.Response response = await http.get(apiUrl,
        headers: <String, String>{
          'x-access-token': 'goldapi-b3cme2ukov6n85p-io',
          'Content-Type': 'application/json'
        });
    // print(response.body);
    data = jsonDecode(response.body);
    print(data['price']);
    // var ab = response.body;
    setState(() {});

  }

  int f_price(document, {flag = 0}){
    int price_ = data['price']!= null?(data['price']).round():0;
    int discount = document.data()["discount"];
    // print("here");
    // print("$discount");
    var weight = document.data()["details"]["weight"]!=null? document.data()["details"]["weight"]:0;
    // print("$weight");
    double carat = document.data()["specifications"]["customizable"]["carat"]!= 22? 0.75:0.917;
    // print("$carat");
    var making =document.data()["details"]["making charges"]!= null?document.data()["details"]["making charges"]:0;
    // print("$making");
    int finalPrice = ((((price_*(weight/28.3495))* carat)+making)*(100-discount)/100).ceil();
    int price =(((price_*(weight/28.3495))* carat)+making).ceil();
    return flag==0? finalPrice: price;
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    final small_padding = (MediaQuery.of(context).size.height)/100;
    final category_padding = small_padding * 5;
    return  Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
          height: screen_width/2,
          child : FutureBuilder<QuerySnapshot>(
              future : _productRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                      body: Center(
                        child: Text("Error : ${snapshot.error}"),
                      )
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                 //   height: screen_height/2.5,
                    child: ListView(
                    //    shrinkWrap: true,
                    //    physics: ScrollPhysics(),
                        //    padding: EdgeInsets.all(small_padding),
                        //   scrollDirection: Axis.horizontal,
                        scrollDirection: Axis.horizontal,
                        //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //    crossAxisCount: 2,
                        //    crossAxisSpacing: 4.0,
                        //    mainAxisSpacing: 5.0,
                        //       ),
                        children: snapshot.data.docs.map((document) {
                          Map<String, dynamic> docData = document.data();
                          return Container(

                            width: screen_width/2,
                      //      height: screen_height/2.5,
                            padding: EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey[400],
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              ),

                              //    height: screen_height/6,
                              // color: Colors.transparent,
                              // padding: EdgeInsets.fromLTRB(3.0, 2.0, 3.0,2.0),
                              // child: InkWell(
                              //   onTap: () {
                              //     Navigator.push(context, MaterialPageRoute(builder: (context) => SecondRoute() )); //test route
                              //   },
                              child: Column(
                                  children: [
                                    Container(

                                      //     padding: EdgeInsets.only(top: category_padding/1.5),
                                        height: screen_width/3,
                                      width: screen_width/3,
                                      child: Image.network(
                                        "${docData['images'][0]}",
                                        fit: BoxFit.fill,),
                                    ),

                                    Container(
                                      height: screen_width/8,
                                      padding: EdgeInsets.only(top: category_padding/4.5),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text( '\u20B9' + " " + "${f_price(document)}",
                                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Raleway",
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left : 2.0,top: 1.0),
                                              child: Text('\u20B9' + "${f_price(document,flag:1)}",
                                                style: TextStyle(fontFamily: "Raleway",
                                                    fontSize: 13,
                                                    color: Colors.blueGrey,
                                                    decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                            )
                                          ]
                                      ),
                                    )
                                  ]),
                              //        ),
                            ),
                          );

                        }

                        ).toList()
                    ),
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
      ),
    );
  }
}
