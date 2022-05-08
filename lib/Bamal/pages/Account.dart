import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// import 'package:sgj/Bamal/pages/Address.dart';
// import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({Key key, this.uid}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(uid);
}

TextEditingController dobcontroller = TextEditingController();
TextEditingController mobilecontroller = TextEditingController();
var signupcollections = FirebaseFirestore.instance.collection('users');
String dob;
String mobile;
String Email;

//Alert Dialogue to choose the Camera/Gallery, KK

class _ProfileState extends State<Profile> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: Column(
              children: [
                Text("-: Choose One :-"),
                RaisedButton(
                  child: Row(
                    children: [Icon(Icons.camera_alt), Text("   Camera")],
                  ),
                  onPressed: () => getImage(ImageSource.camera)
                      .then((value) => Navigator.pop(context)),
                ),
                RaisedButton(
                  child: Row(
                    children: [Icon(Icons.photo), Text("   Gallery")],
                  ),
                  onPressed: () => getImage(ImageSource.gallery)
                      .then((value) => Navigator.pop(context)),
                ),
              ],
            ),
          );
        });
  }

// Profile photo , KK

  File _image;
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);

      setState(() {
        if (image != null) {
          final imageTemporary = File(image.path);
          this._image = imageTemporary;
        }
      });
    } on PlatformException catch (e) {
      print("Failed to pick the image :$e");
    }
  }

  final String uid;
  var taskcollections = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();
  String task;

  _ProfileState(this.uid);

  void submitForm() async {
    await uploadingContact(dob, mobile, Email);
  }

  Future<void> uploadingContact(String dob, String mobile, String Email) async {
    print("DOB : " + dob);
    await FirebaseFirestore.instance
        .collection("users")
        // ignore: deprecated_member_use
        .doc(uid)
        .collection("signup")
        .where("Email", isEqualTo: Email)
        // ignore: deprecated_member_use
        .get()
        .then((res) {
      // ignore: deprecated_member_use
      res.docs.forEach((result) {
        FirebaseFirestore.instance
            .collection("users")
            // ignore: deprecated_member_use
            .doc(uid)
            .collection("signup")
            // ignore: deprecated_member_use
            .doc(result.id)
            // ignore: deprecated_member_use
            .update({
          'MobileNo': mobile,
          'DOB': dob,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.white60,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
          stream: taskcollections
              // ignore: deprecated_member_use
              .doc(uid)
              .collection('signup')
              .snapshots(),
          builder: (context, snapshot) {
            print("Snapshot.hasdata : " + snapshot.hasData.toString());
            if (snapshot.hasData) {
              return ListView.builder(
                // ignore: deprecated_member_use
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  // ignore: deprecated_member_use
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
//                    height: 250,
                    decoration: BoxDecoration(
//                      color: Colors.purple,
//                       borderRadius: BorderRadius.circular(5.0),
                        ),
//                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Image(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                fit: BoxFit.cover,
                                image: _image != null
                                    ? FileImage(_image)
                                    : NetworkImage(
                                        "https://images.unsplash.com/photo-1567131308523-383d0fea9671?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Njd8fGdpcmwlMjAlMjB3aXRoJTIwandlbGxlcnl8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
                              ),
                            ),
                            Positioned(
                              bottom: -60.0,
                              child: CircleAvatar(
                                radius: 80,
                                //backgroundImage: FileImage(_image),
                                backgroundImage: _image != null
                                    ? FileImage(_image)
                                    : NetworkImage(
                                        "https://images.unsplash.com/photo-1567131308523-383d0fea9671?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Njd8fGdpcmwlMjAlMjB3aXRoJTIwandlbGxlcnl8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),

                        // Camera Icon, KK

                        Container(
                          child: RaisedButton(
                            child: Icon(Icons.camera_alt,
                                color: Colors.deepPurple, size: 25),
                            shape: CircleBorder(),
                            onPressed: () {
                              createAlertDialog(context);
                            },
                          ),
                        ),
//                        Text(ds['Email'],style: TextStyle(color: Colors.deepOrange),),
//                        Text(ds['FullName']),
//                        Text(ds['MobileNo']),
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ds['FullName'].toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        // ListTile(
                        //   title: Center(child: Text(ds['FullName'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),)),
                        //   subtitle: Center(child: Text(ds['Email'],style: TextStyle(color: Color(0xFF0B0086)),)),
                        // ),
                        // Text(ds['MobileNo']),

                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.home_outlined,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Center(
                                            child: SingleChildScrollView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              child: AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                title: Text(
                                                  "Do you want to Update Information🖊",
                                                  style: TextStyle(
                                                      fontFamily: 'Raleway',
                                                      fontSize: 15),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                                    // border: OutlineInputBorder(),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    fillColor:
                                                                        Colors
                                                                            .grey,
                                                                    filled:
                                                                        true,
                                                                    labelText:
                                                                        '🖊️ DOB '),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter value ';
                                                              }
                                                              return null;
                                                            },
                                                            // onChanged: (value)
                                                            // {
                                                            //
                                                            // },
                                                            onTap: () async {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      new FocusNode());

                                                              DateTime picked =
                                                                  await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          new DateTime
                                                                              .now(),
                                                                      // Last Date Updated, KK
                                                                      firstDate:
                                                                          new DateTime(
                                                                              1947),
                                                                      lastDate:
                                                                          new DateTime
                                                                              .now());
                                                              String
                                                                  pickedDate =
                                                                  DateFormat(
                                                                          "dd-MM-yyyy")
                                                                      .format(
                                                                          picked);
                                                              if (picked !=
                                                                  null) {
                                                                dobcontroller
                                                                        .text =
                                                                    pickedDate;
                                                                dob =
                                                                    pickedDate;
                                                              }
                                                            },
                                                            controller:
                                                                dobcontroller,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          TextFormField(
                                                            //Keyboard type changed, KK
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                fillColor:
                                                                    Colors.grey,
                                                                filled: true,
                                                                labelText:
                                                                    '🖊️ Mobile Number'),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter ';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (value) {
                                                              mobile = value;
                                                            },
                                                            controller:
                                                                mobilecontroller,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          /* RaisedButton(
                                                            color: Colors.amber,
                                                            child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                            onPressed:()
                                                            {
                                                              Email=ds['Email'];
                                                              if(_formKey.currentState.validate())
                                                              {
                                                                submitForm();
                                                              }
                                                              clearText();
                                                            }
                                                        ),*/
                                                          SizedBox(
                                                            width: 160,
                                                            height: 40,
                                                            child: RaisedButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18.0)),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                color: Colors
                                                                    .deepOrangeAccent,
                                                                child: Text(
                                                                  'Save ❓',
                                                                  style:
                                                                      new TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontFamily:
                                                                        'Raleway',
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  Email = ds[
                                                                      'Email'];
                                                                  if (_formKey
                                                                      .currentState
                                                                      .validate()) {
                                                                    submitForm();
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                  clearText();
                                                                }),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 5),
                                child: Divider(
                                  height: 3,
                                  color: Colors.amber,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "DOB",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 24),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(ds['DOB'] ?? "17/0X/XXXX",
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 18))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Email Address",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 24),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ds['Email'],
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Contact Number",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 24),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ds['MobileNo'] ?? "908443XXX",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                    /* Text("Email - ",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                    Text(ds['Email'],style: TextStyle(fontSize: 20,color: Color(0xFF0B0086), de*/ /*coration: TextDecoration.underline,)),*/
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            color:
                            Color(0xFF0B0086);
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 5,
                            color: Colors.black12,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: FlatButton.icon(
//                        onPressed: (){},
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        label: Text(
                                          "Easy\nReturn ",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Color(0xFF0B0086),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
//
                                      ),
                                      color: Colors.white60,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5 *
                                              (1 / 2),
//                    height: double.infinity,
                                    ),
                                    Container(
                                      child: FlatButton.icon(
//                        onPressed: (){},
                                        icon: Icon(
                                          Icons.swap_horiz,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        label: Text(
                                          "Easy\nExchange",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Color(0xFF0B0086),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
//
                                      ),
                                      color: Colors.white60,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5 *
                                              (1 / 2),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: FlatButton.icon(
//                        onPressed: (){},
                                        icon: Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        label: Text(
                                          "Certified\n Jwellery ",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Color(0xFF0B0086),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
//
                                      ),
                                      color: Colors.white60,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5 *
                                              (1 / 2),
                                    ),
                                    Container(
                                      child: FlatButton.icon(
//                        onPressed: (){},
                                        icon: Icon(
                                          Icons.directions_car,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        label: Text(
                                          "Secured\ndelivery  ",
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Color(0xFF0B0086),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
//
                                      ),
                                      color: Colors.white60,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5 *
                                              (1 / 2),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
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
    );
  }
}

void clearText() {
  dobcontroller.clear();
  mobilecontroller.clear();
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Account extends StatefulWidget {
//   final String uid;
//   Account({this.uid});
//   @override
//   _AccountState createState() => _AccountState(uid);
// }
//
// class _AccountState extends State<Account> {
//
//   final String uid;
//   _AccountState(this.uid);
//
//   var profilecollections = FirebaseFirestore.instance.collection('users');
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
// //          Text("Account & Setting",),
//           SingleChildScrollView(
//             child: Card(
//               margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
//               elevation: 10,
//               shadowColor: Colors.white,
//               child: Column(
//                 children: [
//                   Stack(
//                     overflow: Overflow.visible,
//                     alignment: Alignment.center,
//                     children: [
//                       Image(
//                         width: double.infinity,
//                         height:MediaQuery.of(context).size.height/3,
//                         fit: BoxFit.cover,
//                         image: NetworkImage("https://scontent.fdel25-1.fna.fbcdn.net/v/t1.0-9/p720x720/79603312_2207334646242913_7009164242255347712_o.jpg?_nc_cat=109&ccb=2&_nc_sid=e3f864&_nc_ohc=QzEyBNyPpuEAX9YJotd&_nc_ht=scontent.fdel25-1.fna&tp=6&oh=d86765f5cc23059e28131bea229e86b6&oe=5FCDA703"),
//                       ),
//                       Positioned(
//                           bottom: -60.0,
//                           child: CircleAvatar(
//                             radius: 80,backgroundColor: Colors.white,
//                             backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS8jrR7wnoOAcEHHwmUfxHefefAfg7pBc6Y_g&usqp=CAU"),
//
//                           ))
//                     ],
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   ListTile(
//                     title: Center(child: Text(" Er. Ankit Bamal",style: TextStyle(fontWeight: FontWeight.bold),)),
//                     subtitle: Center(child: Text("ankitbamal99ab@gmail.com",style: TextStyle(color: Color(0xFF0B0086)),)),
//                   ),
//                   ListTile(
//                     title: Text("Contact Details",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(4,0,0,2),
//                     child: Align(
//                       alignment: Alignment(-0.91,0),
//                       child: Container(
//                         child: Column(
//                           children: [
//                             Text(" Contact:        8178368912",style: TextStyle(fontSize: 16),),
//                             SizedBox(height: 5,),
//                             Text("DOB:             15/01/1999",style: TextStyle(fontSize: 16),),
//                             SizedBox(height: 5,),
//                             Text("Joined:          20/03/2020",style: TextStyle(fontSize: 16),),
//                             SizedBox(height: 8,),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         SizedBox(height: 30,),
//         Center(child: Text("Shri Ganga Jweller",style: TextStyle(fontWeight: FontWeight.bold),)),
//         SizedBox(height: 10,),    //  make this row and social ICON
//         Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height/5,
//           color: Colors.black12,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     child: FlatButton.icon(
// //                        onPressed: (){},
//                         icon: Icon(Icons.refresh,color: Colors.black,size: 40,),label: Text("Easy\nReturn ",style: TextStyle(color: Color(0xFF0B0086),fontWeight: FontWeight.bold,fontSize: 16),),
// //
//                     ),
//                     color: Colors.black12,
//                     width: MediaQuery.of(context).size.width/2,
//                      height: MediaQuery.of(context).size.height/5*(1/2),
// //                    height: double.infinity,
//                   ),
//                   Container(
//                     child: FlatButton.icon(
// //                        onPressed: (){},
//                       icon: Icon(Icons.swap_horiz,color: Colors.black,size: 40,),label: Text("Easy\nExchange",style: TextStyle(color: Color(0xFF0B0086),fontWeight: FontWeight.bold,fontSize: 16),),
// //
//                     ),
//                     color: Colors.black12,
//                     width: MediaQuery.of(context).size.width/2,
//                     height: MediaQuery.of(context).size.height/5*(1/2),
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Container(
//                     child: FlatButton.icon(
// //                        onPressed: (){},
//                       icon: Icon(Icons.star,color: Colors.black,size: 40,),label: Text("Certified\n Jwellery ",style: TextStyle(color: Color(0xFF0B0086),fontWeight: FontWeight.bold,fontSize: 16),),
// //
//                     ),
//                     color: Colors.black12,
//                     width: MediaQuery.of(context).size.width/2,
//                     height: MediaQuery.of(context).size.height/5*(1/2),
//                   ),
//                   Container(
//                     child: FlatButton.icon(
// //                        onPressed: (){},
//                       icon: Icon(Icons.directions_car,color: Colors.black,size: 40,),label: Text("Secured\ndelivery  ",style: TextStyle(color: Color(0xFF0B0086),fontWeight: FontWeight.bold,fontSize: 16),),
// //
//                     ),
//                     color: Colors.black12,
//                     width: MediaQuery.of(context).size.width/2,
//                     height: MediaQuery.of(context).size.height/5*(1/2),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
// //          SizedBox(height: 20,)
//         ],
//       ),
//     );
//   }
// }

// Rough Work

/*
StreamBuilder(
stream: Firestore.instance.collection('cars').snapshots(),
builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
if(!snapshot.hasData)
{
return Center(
child:CircularProgressIndicator() ,
);
}
return ListView(
children: snapshot.data.documents.map((document) {
return Center(
child: Container(
width: MediaQuery.of(context).size.width / 1.2,
height: MediaQuery.of(context).size.height / 6,
child: Text("Title: " + document['brandname'],style: TextStyle(color: Colors.black,fontSize: 15),),
),
);
}).toList(),
);
},
),*/

//  for Image -headImageAssetPath : snapshot.data.documents.map()(['url'],)

/*


  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['brandname']),
      subtitle: Text(document['sold']),
    );
  }


StreamBuilder(
                stream: Firestore.instance.collection('cars').snapshots(),
                builder: (context,snapshot){
                if(!snapshot.hasData)
                  return Text("Loading data....");
                return ListView.builder(
                  itemCount: snapshot.data.length,
                    itemExtent: 30,
                    itemBuilder: (context,index)
                    {
                      return _buildList(context, snapshot.data.documents[index]);
                    });
                },
              ),
* */
