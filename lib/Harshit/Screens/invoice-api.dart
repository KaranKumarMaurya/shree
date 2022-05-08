import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sgj/Harshit/Screens/invoice-model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.address, @required this.orderID});

  String orderID;
  String address;
  static User user = FirebaseAuth.instance.currentUser;
  static List<DocumentReference> checkoutList = new List<DocumentReference>();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


Future<http.Response> createUser(String uid, String amount, String address, BuildContext context, String orderID) async{

  String invoiceID;
  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
  Map<String, dynamic > docsnapshotData = docSnapshot.data();
  final Uri apiUrl = Uri(path : "https://api.razorpay.com/v1/invoices");
  QuerySnapshot orderItemsQuery = await FirebaseFirestore.instance.collection("users").doc(uid).collection("temporders").get();
  QuerySnapshot loopLengthQuerySnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).collection("temporders").doc(orderItemsQuery.docs[orderItemsQuery.size-1].id).collection("items").get() ;
  List<Map> lineItems = [];
  for(int i=0; i< loopLengthQuerySnapshot.size ; i++)
    {
      Map<String, dynamic> loopData = loopLengthQuerySnapshot.docs[i].data();
        double price = double.parse((loopData["price"]).toString());
        print("Price : $price");
      //  double discount = double.parse((loopLengthQuerySnapshot.docs[i].data()["discount"]).toString());

     //   price = price - ((price * discount)/100);
        print("Final Price : $price");
        lineItems.add({
          "name" : loopData["Name"],
          "amount" : price*100,
          "currency" : "INR",
          "quantity" : loopData["quantity"]
        }) ;
    }
  print("Address : $address");
  DocumentSnapshot info = await (FirebaseFirestore.instance.collection("users").doc(uid).collection("Address").doc(address).get());
  Map<String, dynamic> infoData = info.data();
  String contact = infoData["PhoneNumber"];
  print("Phone Number : $contact");
  String name = docsnapshotData["Name"];
  print("Name : $name");
//  String address = info.data()["Address"];
  String zipcode = infoData["PINNumber"];
  print("ZipCode : $zipcode");
  print("Amount : $amount");
  // ContentType.json( "application/x-www-form-urlencoded");
 // DocumentSnapshot userInfo = await FirebaseFirestore.instance.collection("users").doc(uid).collection("Address").get()
  String keyID = 'rzp_test_sJT4VNtaupDUEQ';
  String keySceret = 'AZcE0Aj3hCLbPcEyWmDr6uAB';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$keyID:$keySceret'));

  final http.Response response = await http.post(apiUrl,
    headers: <String, String>{
      'authorization': basicAuth,
      'Content-Type': "application/json",
    },
     body: jsonEncode(<String, dynamic>{
    'type': "invoice",
      "customer": {
      "name": name,
      "contact": contact,
      "email": "publicemail545@gmail.com",
      "billing_address": {
        "line1": address,
        "zipcode": zipcode,
        "city": "Bengaluru",
        "state": "Karnataka",
        "country": "in"
      },
      "shipping_address": {
        "line1": address,
        "zipcode":  zipcode,
        "city": "Bengaluru",
        "state": "Karnataka",
        "country": "in",
      }
    },
    "line_items": lineItems,
    // [
    //   {
    //     "name": name,
    //   //  "description": "Book by Ravena Ravenclaw",
    //     "amount": amount,
    //     "currency": "INR",
    //     "quantity": 1
    //   }
    // ],
    "email_notify": 1,
  }),
  );

  if(response.statusCode == 200){
    invoiceID = (jsonDecode(response.body))["id"];
    print("Invoice ID : " + invoiceID);
  //  final String responseString = response.body;
    String url = (jsonDecode(response.body))["short_url"];
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";

 //   return userModelFromJson(responseString);
    print("URL: $url");
    // Navigator.push(context, MaterialPageRoute(builder:(context) {
    //   return WebviewScaffold(url: url);
    // }));
     print("Status : ${(jsonDecode(response.body))["status"]}");


     return response;




  }
  else{
    print(response.statusCode);
    print("failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed failed");
  }
  // print("Invoice ID : $invoiceID");
  // String invID = "https://api.razorpay.com/v1/invoices/" + invoiceID + "/issue" ;
  // print("Inv ID : $invID");
  // final http.Response response2 = await http.post(invID,
  //   headers: <String, String>{
  //     'authorization': basicAuth,
  //     'Content-Type': "application/json",
  //   },
  //   body: jsonEncode({
  //
  //   })
  // );
  //
  // if(response2.statusCode == 200){
  //   String url = (jsonDecode(response2.body))["short_url"];
  //   if (await canLaunch(url))
  //     await launch(url);
  //   else
  //     // can't launch url, there is some error
  //     throw "Could not launch $url";
  // }
  // else{
  //   print(response2.statusCode);
  //   print("Error Occured with Response 2");
  // }

}

class _MyHomePageState extends State<MyHomePage> {
  User user;
  String uid;
  DocumentSnapshot docSnapshot;
  // DocumentSnapshot docSnapshot;
  @override
  void initState() {
    super.initState();
    // docSnapshot= await FirebaseFirestore.instance.collection("Products").doc(widget.productKey).get();
    user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
    // FirebaseFirestore.instance.collection("users").doc(uid).get().then((snap) {
    //   docSnapshot = snap;
    // });

  }

  UserModel _user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  var taskcollections = FirebaseFirestore.instance.collection('users');
  String FullName;
  String amount;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:Container(
        padding: EdgeInsets.all(32),
        child: StreamBuilder<QuerySnapshot>(
          stream: taskcollections
          // ignore: deprecated_member_use
              .doc(uid)
              .collection('orders')
              .snapshots(),
          builder: (context, snapshot)
          // ignore: missing_return
          {
            if (snapshot.hasData)
            {
              // return ListView.builder(
              //   itemCount: snapshot.data.docs.length,
              //     itemBuilder: (context, index)
              //     {
              //       DocumentSnapshot ds = snapshot.data.docs[index];
              //       FullName =ds['Name'];
              //       amount=ds['price'];
                    //return null;

                    final String name = nameController.text;
                    print("FullName : $FullName");
                    http.Response resp;
                    (createUser(uid,amount,widget.address,context, widget.orderID)).then((userModel){
                      resp = userModel;

                      checkStatus(resp);
                    });

                    // setState(() {
                    //   _user = user;
                    // });
                  }
         //     );
            return Text("Redirecting...");
          },
        )
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async{
      //     final String name = nameController.text;
      //     print("FullName : $FullName");
      //     final UserModel user = await createUser(uid,amount,widget.address, context);
      //
      //     setState(() {
      //       _user = user;
      //     });
      //
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
   //   ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


void checkStatus(http.Response resp)
async{
  String invoiceID = (jsonDecode(resp.body))["status"];
  String keyID = 'rzp_test_sJT4VNtaupDUEQ';
  String keySceret = 'AZcE0Aj3hCLbPcEyWmDr6uAB';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$keyID:$keySceret'));

  final http.Response response2 = await http.post(Uri(path : "https://api.razorpay.com/v1/invoices/$invoiceID"),
    headers: <String, String>{
      'authorization': basicAuth,
      'Content-Type': "application/json",
    },
  );


  if(response2.statusCode == 200) {
    String status = (jsonDecode(response2.body))["status"];
    print("Status : $status");
  }
  else
    {
      print("Error occured while retrieving status!");
      checkStatus(resp);
    }
}

class WbView extends StatelessWidget {
  WbView({@required this.url});

  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
       initialUrl: url,
      ),
    );
  }
}

