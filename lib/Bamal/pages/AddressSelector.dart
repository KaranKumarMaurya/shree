import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgj/Bamal/pages/Address.dart';
import 'package:sgj/Harshit/Screens/payment-gateway.dart';

class AddressSelector extends StatefulWidget {
  var signupcollections = FirebaseFirestore.instance.collection('users');

  var taskcollections = FirebaseFirestore.instance.collection('users');

  @override
  _AddressSelectorState createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  String userID;
  int selection;
  String address;

  @override
  void initState() {
    userID = FirebaseAuth.instance.currentUser.uid;
    selection = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      persistentFooterButtons: [
        Container(
          width: screenWidth,
          height: screenWidth / 8,
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
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      insetPadding: EdgeInsets.fromLTRB(
                          screenWidth / 5,
                          screenHeight / 2.5,
                          screenWidth / 3,
                          screenHeight / 2.5),
                      child: Container(
                          child:
                              Center(child: new CircularProgressIndicator())),
                    );
                  });
              //  if(isAdded == false)
              //    progressDialog.dismiss();
              print("Address in Address Selector : $address");
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => PaymentScreen(address: address,)
              // ));

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => PaymentScreen(
                            address: address,
                          )));
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Container(
                child: Center(
                    child: Text(
              "Next",
              style: TextStyle(
                color: Color.fromRGBO(255, 92, 0, 1),
                fontFamily: 'Raleway',
              ),
            ))),
          ),
        )
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: widget.taskcollections
                      // ignore: deprecated_member_use
                      .doc(userID)
                      .collection('Address')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        // ignore: deprecated_member_use
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          // ignore: deprecated_member_use
                          DocumentSnapshot ds = snapshot.data.docs[index];
                          return ListTile(
                            leading: Radio(
                              value: index,
                              groupValue: selection,
                              onChanged: (value) {
                                setState(() {
                                  selection = value;
                                  address = snapshot.data.docs[index].id;
                                  //    print("Address 1 : $address");
                                });
                              },
                            ),
                            title: Card(
                              child: Center(
                                child: InkWell(
                                  onLongPress: () {
                                    print('Pressed');
                                    //  toggleSelection();
                                  },
                                  highlightColor: Colors.deepOrangeAccent,
                                  child: Container(
//                    height: 250,
                                    decoration: BoxDecoration(
//                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
//                    margin: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
//                        Text(ds['Email'],style: TextStyle(color: Colors.deepOrange),),
//                        Text(ds['FullName']),
//                        Text(ds['MobileNo']),
                                        SizedBox(
                                          height: 60,
                                        ),
                                        ListTile(
                                          // selected: isSelected,
                                          title: Center(
                                              child: Text(
                                            ds['Name'],
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          )),
                                          subtitle: Center(
                                              child: Text(
                                            ds['PhoneNumber'],
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                color: Color(0xFF0B0086)),
                                          )),
                                          // onLongPress: toggleSelection,
                                        ),

                                        Text(ds['PINNumber']),
                                        SizedBox(
                                            width: 150,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(ds['Address']))),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: Text(
                        "No Address Available" + " " + "\u2639",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ));
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),

          // Adding new Address, KK
          Card(
            elevation: 3,
            child: MaterialButton(
              onPressed: () {
                print('user id');
                print(FirebaseAuth.instance.currentUser.uid);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Address(
                            uid: FirebaseAuth.instance.currentUser.uid)));
              },
              child: Text("Add New Address"),
            ),
          )
        ],
      ),
    );
  }
}
