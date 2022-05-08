import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgj/components/HomePage/adinfo.dart';
import 'package:sgj/components/HomePage/product_display_grid.dart';
import 'package:sgj/components/HomePage/categories.dart';
import 'package:sgj/components/ProductPage/product_page.dart';
import 'package:sgj/ReplicateProducts.dart';


// void main() {
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shri Ganga Jewellers',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.white,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Shri Ganga Jewellers'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: _initialization,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Scaffold(
    //             body: Center(
    //               child: Text("Error : ${snapshot.error}"),
    //             )
    //         );
    //       }
    //
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return Scaffold(
    //           body: Container(
    //             child: Center(
    //               child: Text("Firebase App Initialized"
    //               ),
    //             ),
    //           ),
    //         );
    //       }
    //
    //
    //       return Scaffold(
    //         body: Center(
    //           child: Text("Initialization App..."),
    //         ),
    //       );
    //     }
    // );
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    final small_padding = (MediaQuery.of(context).size.height)/100;

    return Scaffold(
        drawer: SafeArea(
          child: Drawer(
            child: ListView(
              children : [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.0,
                            color: Colors.grey
                        )
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: screen_width/16,
                            width: screen_width/8,
                            child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/Bangles.svg?alt=media&token=e36c72bd-cf2c-43b8-b1b5-46ee4bbd4094")
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0),
                          child: Text("Jewellery Category No. 1",
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                            color: Colors.grey
                        ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                          bottom: BorderSide(width: 2.0,
                              color: Colors.grey
                          )
                        )
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: screen_width/16,
                            width: screen_width/8,
                            child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/earrings.svg?alt=media&token=e7d985e6-b814-4728-bc8c-eb82dab72efb")
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0),
                          child: Text("Jewellery Category No. 2",
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: BorderSide(width: 2.0,
                                color: Colors.grey
                            )
                        )
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: screen_width/16,
                            width: screen_width/8,
                            child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/silverjewellery.svg?alt=media&token=6697870f-fe00-45b8-9a53-67858fe330b4")
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0),
                          child: Text("Silver Jewellery Store",
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: BorderSide(width: 2.0,
                                color: Colors.grey
                            )
                        )
                    ),
                    padding: EdgeInsets.fromLTRB(16.0,10.0,10.0,10.0 ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top : 2.0),
                          child: Container(
                              height: screen_width/12,
                              width: screen_width/8,
                              child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/newarrivals.svg?alt=media&token=41bf53b3-b22d-4b21-82dd-f5c07432b230")
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0),
                          child: Text("New Arrivals",
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 3.0,bottom: 3.0),
                          child: Text("NEW!",
                          style: TextStyle(
                            color: Colors.orange,
                            fontStyle: FontStyle.italic,
                            fontSize: 8
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: BorderSide(width: 2.0,
                                color: Colors.grey
                            )
                        )
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: screen_width/12,
                            width: screen_width/8,
                            child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/faq1.svg?alt=media&token=ff8d1e6d-f3de-4468-8463-251e66ce1158")
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0,bottom: 5),
                          child: Text("FAQ's",
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child : Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: BorderSide(width: 2.0,
                                color: Colors.grey
                            )
                        )
                    ),
                    padding: EdgeInsets.fromLTRB(16.0,10.0,6.0,6.0 ),
                    child: Row(
                      children: [
                        Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom : 35.0),
                          child: Container(
                              height: screen_width/8,
                              width: screen_width/8,
                              child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/help1.svg?alt=media&token=cf45ef87-bfab-4323-8842-f931ec25ac04")
                          ),
                        ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left : 15.0),
                              child: Text("Need Help?",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:2.0, top: 8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: SvgPicture.asset("assets/whatsapp.svg",
                                          fit: BoxFit.fill,
                                          height: screen_width/12,
                                          width : screen_width/12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(16.0, 8.0,8.0,8.0),
                                    child: Container(
                                      child: SvgPicture.network(
                                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/phone.svg?alt=media&token=8f720f1f-44d4-49f6-ae25-934b940b3397",
                                          fit: BoxFit.fill,
                                          height: screen_width/14,
                                          width : screen_width/14),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: BorderSide(width: 2.0,
                                color: Colors.grey
                            )
                        )
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: screen_width/12,
                            width: screen_width/8,
                            child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/trackorder.svg?alt=media&token=4df41f75-f146-4c6c-9d28-9688b81fa84e")
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0,bottom: 5),
                          child: Text("Track Order",
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: BorderSide(width: 2.0,
                                color: Colors.grey
                            )
                        )
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: screen_width/12,
                            width: screen_width/8,
                            child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/sendfeedbackmail.svg?alt=media&token=b7cadebe-3d79-4596-b703-11542d952344")
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0,bottom: 5),
                          child: Text("Send Feedback Mail",
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                    child : Container(
                      decoration: BoxDecoration(
                          border: Border(
                              left : BorderSide(width: 2.0,
                                  color: Colors.grey
                              ),
                              right : BorderSide(width: 2.0,
                                  color: Colors.grey
                              ),
                              bottom: BorderSide(width: 2.0,
                                  color: Colors.grey
                              )
                          )
                      ),
                      padding: EdgeInsets.fromLTRB(16.0,10.0,6.0,6.0 ),
                      child: Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom : 35.0),
                              child: Container(
                                  height: screen_width/8,
                                  width: screen_width/8,
                                  child : SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/followuson.svg?alt=media&token=d89ec250-c3bc-4f8f-b56f-72eb00205d2b")
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left : 15.0),
                                child: Text("Follow Us On",
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:2.0, top: 8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: SvgPicture.network("https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/yt.svg?alt=media&token=d2e0e909-42d2-440e-8e71-4f50834dc0ab",
                                            fit: BoxFit.fill,
                                            height: screen_width/10,
                                            width : screen_width/10),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16.0, 8.0,8.0,8.0),
                                      child: Container(
                                        child: SvgPicture.network(
                                            "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/fb.svg?alt=media&token=be3bcd0b-0e08-44d1-8292-5fc152a86bc9",
                                            fit: BoxFit.fill,
                                            height: screen_width/10,
                                            width : screen_width/10),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16.0, 8.0,8.0,8.0),
                                      child: Container(
                                        child: SvgPicture.network(
                                            "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/ig.svg?alt=media&token=8aada295-6f73-4975-848b-d5c45e922abf",
                                            fit: BoxFit.fill,
                                            height: screen_width/10,
                                            width : screen_width/10),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            right : BorderSide(width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: BorderSide(width: 2.0,
                                color: Colors.grey
                            )
                        )
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: screen_width/12,
                            width: screen_width/8,
                            child : SvgPicture.network(
                                "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/myaccount.svg?alt=media&token=04369f5b-a8ba-4145-9361-232a1eceaa6d")
                        ),
                        Container(
                          padding: EdgeInsets.only(left : 15.0,bottom: 5),
                          child: Text("My Account",
                            style: TextStyle(
                                fontSize: 16
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
            title: Text(title,
              style: TextStyle(color: Color(0xFF0B0086)),
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
                      color: Colors.black)
              ),
              IconButton(
                  icon: Icon(Icons.shopping_bag_outlined,
                      color: Colors.black)
              )
            ]
        ),

        body: SingleChildScrollView(
          child: Container(
            color: Colors.blueGrey[50],
              child:
              Column(
                  children: [
                  categories(),
                  ad_display(),
                  ProductDisplayGrid()
                 //   ProductPage(productKey : "BOYcC16PFoQXHnAgiHe3")
                  ]
              )
          ),
        )
    );
  }
}
