import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sgj/Harshit/Screens/invoice-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgj/Harshit/Screens/invoice-api.dart';
// import 'package:toast/toast.dart';

// class Response {
//   var orderID;
//
//   factory Response.fromJson(Map<String, dynamic> json){
//       return Response(
//         orderID : json['order_id']
//       )
//   }
// }

class PaymentScreen extends StatefulWidget {
  PaymentScreen({@required this.address});

  static Map docSnap;
  static String orderName;
  String address;
 // static String addr;
  // final String productKey;
  // PaymentScreen({@required this.productKey});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String orderID;
  dynamic orderRef;
  User user = FirebaseAuth.instance.currentUser;
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingControllerName = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);


  }

  @override
  void dispose() {
    
    super.dispose();
    razorpay.clear();
  }

  Future createOrder(String uid, String FullName, String amount) async{

    final Uri apiUrl = Uri(path : "https://api.razorpay.com/v1/orders");
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
        'amount' : amount,
        'currency' : 'INR',
        'receipt' : 'receipt#1'
      }),
    );

    if(response.statusCode == 200)
      {
        print("Order created successfully!");
        print("Response Code : " + ((jsonDecode(response.body))["id"]));
      }
    return (json.decode(response.body))["id"];

  }

  void openCheckout(int amount, String name, String orderID){
    var options = {
      "key" : "rzp_test_sJT4VNtaupDUEQ",
      "amount" : amount,
      "name" : name,
      "order_id" : orderID,
      "description" : "Payment for the some random product",
      "prefill" : {
        "contact" : "2323232323",
        "email" : "shdjsdh@gmail.com"
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async{

    // widget.address;
    print("Payment success");
    // Toast.show("Pament success", context);
    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);

   // DocumentSnapshot orderSnap = await orderRef.get();
    QuerySnapshot temporders = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("temporders").get();
    QuerySnapshot orders = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("orders").get();
    int num = orders.size + 1;
    String docName = "Order"+ "$num" ;

    await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("orders").doc(docName).set({});
    QuerySnapshot itemsList = await temporders.docs.last.reference.collection("items").get();

    for (int i = 0; i < itemsList.size; i++) {
      // int discount = orderData.docs[i].data()["discount"];
      // amount += ((price * (100 - discount)) ~/ 100);
      await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("orders").doc(docName).collection("items").add(itemsList.docs[i].data());

    }
    //await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("orders").doc(PaymentScreen.orderName).collection(collectionPath);
    await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("temporders").get().then((snapshot)
    {
      for (DocumentSnapshot ds in snapshot.docs)
        ds.reference.delete();
    });
    print("Data shown " + PaymentScreen.docSnap.toString());
   // Navigator.push(context, MaterialPageRoute(builder : (BuildContext context) => MyHomePage(address: widget.address, orderID: orderID,)));
  }

  void handlerErrorFailure(PaymentFailureResponse response){
    // print("Pament error");
    // Toast.show("Pament error", context);
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
      timeInSecForIosWeb: 4);
  }

  void handlerExternalWallet(ExternalWalletResponse response){
    // print("External Wallet");
    // Toast.show("External Wallet", context);
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Gateway"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .collection("temporders")
              .get(),
          builder: (context, snapshot) {
            print("Address in payment Gateway : ${widget.address}");
            if(snapshot.hasData) {
              String name;
              FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((docReference){
                String Dataisnotempty = docReference.data().toString();
                Map<String, dynamic> nameMap = docReference.data();
                bool containskey = nameMap.containsKey("Name");
                name = nameMap["Name"];
                print("Name = $name");
                print("Name = ${nameMap.toString()}");
                textEditingControllerName.text = "$name";
              });

              print("Name2 = $name");
              // QuerySnapshot tempOrders = await FirebaseFirestore.instance
              //     .collection("users")
              //     .doc(user.uid)
              //     .collection("temporders")
              //     .get();
              //  List<QueryDocumentSnapshot> listDocs = tempOrders.docs;
              int num = snapshot.data.size - 1;
              print(num);
              int amount = 0;
           //  QuerySnapshot orderData =
              PaymentScreen.orderName = snapshot.data.docs[num].reference.id;
              print("Order Name : ${PaymentScreen.orderName}");
              orderRef = snapshot.data.docs[num];
              PaymentScreen.docSnap = orderRef.data();
              print("Order Data : ${PaymentScreen.docSnap.toString()}");
              print("Doc ID : ${snapshot.data.docs[num].id}");
              snapshot.data.docs[num].reference.collection("items").get().then((orderData){
                for (int i = 0; i < orderData.size; i++) {
                  int price = orderData.docs[i].data()["price"];
                  print(price);
                 // int discount = orderData.docs[i].data()["discount"];
                 // amount += ((price * (100 - discount)) ~/ 100);
                  amount += price;
                  print("amount in loop : $amount");
                }

                textEditingController.text = "$amount";
                amount *= 100;
              });

             // print("Amount = $amount");


              return Column(
                children: [
                  TextField(
                    controller: textEditingControllerName,
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(hintText: "amount to pay"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Pay Now",
                      style: TextStyle(fontFamily: 'Raleway',color: Colors.white),
                    ),
                    onPressed: () async {
                      orderID = await createOrder(user.uid, name, amount.toString());
                      print(orderID);
                      print("Amount before going to Checkout : $amount");
                      openCheckout(amount, name, orderID);
                    },
                  )
                ],
              );
            }

            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
        }),
      ),
    );
  }
}
