import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  static _AddressState of(BuildContext context) =>
      context.findAncestorStateOfType<_AddressState>();
  final String uid;

  const Address({Key key, this.uid}) : super(key: key);

  @override
  _AddressState createState() => _AddressState(uid);
}

TextEditingController firstNameController = TextEditingController();
TextEditingController secondNameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController pinNumberController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController address2Controller = TextEditingController();
String FirstName;
String SecondName;
String PhoneNumber;
String PINNumber;
String address;
String address2;

var signupcollections = FirebaseFirestore.instance.collection('users');

class _AddressState extends State<Address> {
  final String uid;

  final _formKey = GlobalKey<FormState>();
  bool ispress = false;
  int count = 0;
  var isSelected = false;
  var mycolor = Colors.white;
  int selection = 0;

  _AddressState(this.uid);

  void submitForm() async {
    await uploadingAddress(
        FirstName, SecondName, PhoneNumber, PINNumber, address, address2);
  }

  void toggleSelection() {
    print('Call toggleSeclection');
    setState(() {
      if (isSelected) {
        // border=new BoxDecoration(border: new Border.all(color: Colors.white));
        mycolor = Colors.blue;
        isSelected = false;
      } else {
        mycolor = Colors.redAccent;
        isSelected = true;
      }
    });
  }

  @override
  Widget _buildchild(bool choice, Function update) {
    if (choice == true)
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          color: Colors.black12,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Delivery Address",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Raleway",
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  // disabledBorder: OutlineInputBorder(),
                                  labelText: 'Recipient Full Name',
                                  labelStyle: TextStyle(
                                      fontFamily: "Raleway",
                                      color: Colors.black,
                                      backgroundColor: Colors.transparent)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Full Name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                FirstName = value;
                              },
                              controller: firstNameController,
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  // disabledBorder: OutlineInputBorder(),
                                  labelText: 'Recipient Phone Number',
                                  labelStyle: TextStyle(
                                      fontFamily: "Raleway",
                                      color: Colors.black)),
                              validator: (value) {
                                if (value.length != 10) {
                                  return 'Please enter valid  Number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                PhoneNumber = value;
                              },
                              controller: phoneNumberController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  // disabledBorder: OutlineInputBorder(),
                                  labelText: 'PIN Number',
                                  labelStyle: TextStyle(
                                      fontFamily: "Raleway",
                                      color: Colors.black)),
                              validator: (value) {
                                if (value.length != 6) {
                                  return 'Please enter valid PIN';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                PINNumber = value;
                              },
                              controller: pinNumberController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                  // disabledBorder: OutlineInputBorder(),
                                  labelText: 'Address Line 1',
                                  labelStyle: TextStyle(
                                      fontFamily: "Raleway",
                                      color: Colors.black)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter address';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                address = value;
                              },
                              controller: addressController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    // disabledBorder: OutlineInputBorder(),
                                    labelText: 'Address Line 2',
                                    labelStyle: TextStyle(
                                        fontFamily: "Raleway",
                                        color: Colors.black)),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter address';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  address2 = value;
                                },
                                controller: address2Controller),
                            SizedBox(
                              height: 14,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                width: 145,
                                height: 37,
                                child: RaisedButton(
                                  color: Colors.deepOrange,
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  onPressed: () {
                                    // submit button
                                    if (_formKey.currentState.validate()) {
                                      submitForm();
                                      update(false);
                                      clearText();

                                      //                            Navigator.of(context).pouplp();
                                    }
                                    //clearText();
                                  },
                                ),
                              ),
                            ),
                            //                            FlatButton(
                            //                                onPressed: (){},
                            //                                child: Text("Save",style:TextStyle(fontSize: 20),),
                            //                              color: Colors.deepOrange,
                            //                              textColor: Colors.white,
                            //                              shape: RoundedRectangleBorder(
                            //                                borderRadius: BorderRadius.circular(11),
                            //                              ),
                            //                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    else {

      // Editing of the Address, KK
      var taskcollections = FirebaseFirestore.instance.collection('users');
      return Material(
        child: Padding(
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
                stream: taskcollections
                    // ignore: deprecated_member_use
                    .doc(uid)
                    .collection('Address')
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      // ignore: deprecated_member_use
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        // ignore: deprecated_member_use
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        Future<bool> alertDialog(
                            {fullName, phNumber, pNumber, add, add2}) {
                          TextEditingController fullNameController =
                              TextEditingController(text: fullName);
                          TextEditingController phNumberController =
                              TextEditingController(text: phNumber);
                          TextEditingController pNumberController =
                              TextEditingController(text: pNumber);
                          TextEditingController addController =
                              TextEditingController(text: add);

                          return showDialog(
                              context: context,
                              builder: (context) => new AlertDialog(
                                    title: Column(
                                      children: [
                                        TextFormField(
                                          controller: fullNameController,
                                          onChanged: (String value) {
                                            setState(() {
                                              fullName = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Full Name",
                                            labelStyle:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: phNumberController,
                                          onChanged: (String value) {
                                            setState(() {
                                              phNumber = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Phone Number",
                                            labelStyle:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: pNumberController,
                                          onChanged: (String value) {
                                            setState(() {
                                              pNumber = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: "PIN Number",
                                              labelStyle: TextStyle(
                                                  color: Colors.blue)),
                                        ),
                                        TextFormField(
                                          controller: addController,
                                          onChanged: (String value) {
                                            setState(() {
                                              add = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: "Address",
                                              labelStyle: TextStyle(
                                                  color: Colors.blue)),
                                        ),
                                        Container(
                                          width: 300,
                                          margin: EdgeInsets.only(top: 10),
                                          child: RaisedButton(
                                            color: Colors.red,
                                            child: Text(
                                              "Update Data",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(uid)
                                                  .collection("Address")
                                                  .doc(ds.id)
                                                  .update({
                                                'Name': fullNameController.text,
                                                'Address': addController.text,
                                                'PINNumber':
                                                    pNumberController.text,
                                                'PhoneNumber':
                                                    phNumberController.text,
                                              }).then((value) =>
                                                      Navigator.pop(context));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        }

                        return ListTile(
                            // leading: Radio(
                            //   value: index,
                            //   groupValue: selection,
                            //   onChanged: (value){
                            //   setState(() {
                            //     selection = value;
                            //   });
                            //   },
                            // ),
                            title: Card(
                          child: Center(
                            child: InkWell(
                              onLongPress: () {
                                print('Pressed');
                                toggleSelection();
                              },
                              highlightColor: Colors.deepOrangeAccent,
                              child: Container(
//                    height: 250,
                                decoration: BoxDecoration(
//                      color: Colors.purple,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
//                    margin: EdgeInsets.all(8.0),
                                child: Column(children: [
//                        Text(ds['Email'],style: TextStyle(color: Colors.deepOrange),),
//                        Text(ds['FullName']),
//                        Text(ds['MobileNo']),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  ListTile(
                                    // selected: isSelected,
                                    title: Center(
                                        child: Text(
                                      ds['Name'],
                                      style: TextStyle(
                                          fontFamily: "Raleway", fontSize: 20),
                                    )),
                                    subtitle: Center(
                                        child: Text(
                                      ds['PhoneNumber'],
                                      style: TextStyle(
                                          fontFamily: "Raleway",
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

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                    // Delete property, KK
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(uid)
                                                .collection("Address")
                                                .doc(ds.id)
                                                .delete();
                                          }),
                                      // Edit property, KK
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          alertDialog(
                                              fullName: ds["Name"],
                                              phNumber: ds["PhoneNumber"],
                                              pNumber: ds["PINNumber"],
                                              add: ds["Address"]);
                                        },
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return CircularProgressIndicator();
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  "Delivery Address",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
//              visualDensity: VisualDensity(vertical: 5),
                subtitle: Text("+ Add new Address",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                leading: CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      count++;
                      if (count % 2 == 0) {
                        ispress = false; // showing previous Address
                      } else
                        ispress = true; // showing add new Address

                      setState(() {
                        _buildchild(ispress, (choice) {
                          setState(() {
                            ispress = choice;
                          });
                        });
                        //ispress = false;
                      });

                      //ispress = false;
                    },
                  ),
                ),
              ),
            ),
//          Text("SJG",style:TextStyle(fontWeight: FontWeight.bold),),
            _buildchild(ispress, (choice) {
              setState(() {
                ispress = choice;
              });
            }),
          ],
        ),
      ),
    );
  }

  Future<void> uploadingAddress(
      String firstName,
      String secondName,
      String phoneNumber,
      String pinNumber,
      String address,
      String address2) async {
    // ignore: deprecated_member_use
    return await signupcollections.doc(uid).collection('Address').add({
      'Name': firstName,
      'PhoneNumber': phoneNumber,
      'PINNumber': pinNumber,
      'Address': address + " " + address2,
      'createdAt': FieldValue.serverTimestamp()
    });
  }
}

void clearText() {
  firstNameController.clear();
  secondNameController.clear();
  pinNumberController.clear();
  phoneNumberController.clear();
  addressController.clear();
  address2Controller.clear();
}

// import 'package:flutter/material.dart';
//
// class Address extends StatefulWidget {
//   @override
//   _AddressState createState() => _AddressState();
// }
//
// class _AddressState extends State<Address> {
//
//   bool ispress=false;
//   int count=0;
//
//   @override
//   Widget _buildchild(bool choice)
//   {
//     if(choice==true)
//       return Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Container(
//           child: Column(
//             children: [
//               Text("Delivery Address",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//               SizedBox(height: 5,),
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Container(
//                   child: Column(
//                     children: [
//                       Form(
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 labelText: 'Recipient First Name'
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Recipient Last Name'
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Recipient Phone Number'
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'PIN Number'
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Address Line 1'
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Address Line 2'
//                               ),
//                             ),
//                             SizedBox(height: 14,),
//                             Align(
//                               alignment: Alignment.bottomLeft,
//                               child: SizedBox(
//                                 width: 145,
//                                 height: 37,
//                                 child: RaisedButton(
//                                   color: Colors.deepOrange,
//                                   child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 20),),
//                                   onPressed: (){},
//                                 ),
//                               ),
//                             ),
// //                            FlatButton(
// //                                onPressed: (){},
// //                                child: Text("Save",style:TextStyle(fontSize: 20),),
// //                              color: Colors.deepOrange,
// //                              textColor: Colors.white,
// //                              shape: RoundedRectangleBorder(
// //                                borderRadius: BorderRadius.circular(11),
// //                              ),
// //                            ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     else
//       return Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.black12,
//           ),
//
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text("Ankit Bamal\n8178368912\nVill+Post :- Hoshdar Pur Garhi\nDistt:- Hapur (UP)\n245201\nNationality:- Indian\nProud to be a JAAT\n ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
//           ),
//         ),
//       );
//
//   }
//
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListTile(
//               title: Text("Delivery Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
// //              visualDensity: VisualDensity(vertical: 5),
//               subtitle: Text("+ Add new Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
//               leading: IconButton(
//                 icon:Icon(Icons.add),
//                 onPressed: (){
//                   count++;
//                   if(count%2==0)
//                   {
//                     ispress=false;    // showing previous Address
//                   }else
//                     ispress=true;     // showing add new Address
//
//                   setState(() {
//                     _buildchild(ispress);
//                   });
//                 },
//               ),
//             ),
//           ),
// //          Text("SJG",style:TextStyle(fontWeight: FontWeight.bold),),
//           _buildchild(ispress),
//         ],
//       ),
//     );
//   }
// }
