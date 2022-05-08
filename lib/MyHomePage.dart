import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgj/Bamal/FAQ.dart';
//import 'package:sgj/Bamal/HomePage.dart';
import 'package:sgj/TopBar/AppBar.dart';
import 'package:sgj/TopBar/SideDrawer.dart';
import 'package:sgj/components/HomePage/adinfo.dart';
import 'package:sgj/components/HomePage/categories.dart';
import 'package:sgj/components/HomePage/product_display_grid.dart';
import 'package:sgj/HomePage.dart';
import 'package:sgj/components/Bag/Bag.dart';
// import 'Harshit/Screens/address-and-delivery.dart';
import 'components/Search/CloudFirestoreSearch.dart';

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
        drawer: SideDrawer(),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
            title: Text("Shree Ganga Jewellers",
              style: TextStyle(color: Colors.white,fontFamily: "Raleway",),
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
                  Navigator.pushNamed(context, '/cart') ;
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => Bag() ));
                },
              )
            ]
        ),
        body: MainPage()
    );
  }
}