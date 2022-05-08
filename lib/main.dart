import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgj/components/Bag/Bag.dart';
import 'package:sgj/Harshit/Screens/landing_page.dart';
import 'package:sgj/Harshit/widgets/service_locator.dart';
import 'package:sgj/ReplicateProducts.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 setupLocator();
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         primaryColor: Colors.white,
         visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       // home: LandingPage(),
      routes: {
        '/' : (context) => LandingPage(),
        '/cart' : (context) => Bag()
      },
        );
  }
}

// class MyApp extends StatelessWidget {
//   Query cR = FirebaseFirestore.instance.collection("Products");
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     var screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           height: screenHeight,
//           width: screenWidth,
//           child: Center(
//             child: Container(
//               height: 50,
//               width: 200,
//               child: FutureBuilder(
//                   future: cR.where("searchKeywords", arrayContains: "earrings").get(),
//                   builder: (context, snapshot) {
//                     if(snapshot.hasData){
//                       int i = -1;
//                       List names = new List(6);
//                       names = [
//                         "Bangles",
//                         "Bracelets",
//                         "Earrings",
//                         "Pendants",
//                         "Rings"
//                       ];
//                       List<List> keyWords = new List(6);
//                       keyWords = [["n", "ne", "nec", "neck", "neckl", "neckla", "necklac","necklace", "necklaces"], ["r", "ri", "rin", "ring", "rings"], ["b", "ba", "ban", "bang", "bangl", "bangle", "bangles"], ["e", "ea", "ear", "earr", "earri", "earrin", "earring", "earrings"], ["p", "pe", "pen", "pend", "penda", "pendan", "pendant", "pendants"], ["b", "br", "bra", "brac", "brace", "bracel", "bracele", "bracelet", "bracelets"] ];
//                       return ElevatedButton(
//                         child: Container(
//                           // height: 18,
//                           //   width: 18,
//                             child: Center(
//                                 child: Text(
//                           "Perform",
//                           style: TextStyle(color: Color.fromRGBO(255, 92, 0, 1)),
//                         ))),
//                         onPressed: () {
//                           snapshot.data.docs.map((document) async {
//                             List<String> imagesList = [];
//                             i++;
//                             print("${document.data()["Name"]}");
//                             if(i%2==0)
//                               {
//                                   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('Earrings/Pic1.jpg');
//                                   String Link = await ref.getDownloadURL();
//                                   print(Link);
//                                   imagesList.add("$Link");
//
//                                   ref = firebase_storage.FirebaseStorage.instance.ref('Earrings/Pic3.jpg');
//                                   Link = await ref.getDownloadURL();
//                                   imagesList.add("$Link");
//                                   print(Link);
//                                   ref = firebase_storage.FirebaseStorage.instance.ref('Earrings/Pic4.jpg');
//                                   Link = await ref.getDownloadURL();
//                                   imagesList.add("$Link");
//                                   print(Link);
//                               }
//                             else
//                               {
//                                 firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('Earrings/Pic2.jpg');
//                                 String Link = await ref.getDownloadURL();
//                                 imagesList.add("$Link");
//
//                                 ref = firebase_storage.FirebaseStorage.instance.ref('Earrings/Pic3.jpg');
//                                 Link = await ref.getDownloadURL();
//                                 imagesList.add("$Link");
//
//                                 ref = firebase_storage.FirebaseStorage.instance.ref('Earrings/Pic4.jpg');
//                                 Link = await ref.getDownloadURL();
//                                 imagesList.add("$Link");
//
//                               }
//                             await FirebaseFirestore.instance
//                                 .collection("Products")
//                                 .doc(document.id)
//                                 .update({
//                               'images' : imagesList
//                               // 'Name': '${names.elementAt(i ~/ 2)} $i',
//                              // 'searchKeywords' : keyWords.elementAt(i ~/ 2)
//                             });
//
//                           }).toList();
//                           },
//                       );
//                     }
//                     else if (snapshot.hasError) {
//                       return Text("${snapshot.error}");
//                     }
//
//                     return Center(child: CircularProgressIndicator());
//                   }
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('Products/Product 1/Images/41yC68UiO8L.jpg');
//
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     var screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           height: screenHeight,
//           width: screenWidth,
//           child: Center(
//             child: Container(
//               height: 50,
//               width: 200,
//               child: ElevatedButton(
//                         child: Container(
//                           // height: 18,
//                           //   width: 18,
//                             child: Center(
//                                 child: Text(
//                                   "Perform",
//                                   style: TextStyle(color: Color.fromRGBO(255, 92, 0, 1)),
//                                 )
//                               )
//                               ),
//                         onPressed: () async{
//                           String URL = await ref.getDownloadURL();
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage(ref: URL) ));
//                         },
//                       )
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }
//
// class NewPage extends StatelessWidget {
//   NewPage({@required this.ref});
//   final String ref;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child : Text("Hi " + "$ref",
//         style: TextStyle(
//           fontSize: 25.0
//         ),
//       ),
//     );
//   }
// }
//
