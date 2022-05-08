import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgj/Bamal/pages/operation.dart';
//import 'package:sgj/Bamal/pages/operation.dart';



class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Address").snapshots(),
        builder: (context, snapshot) {
          // ignore: deprecated_member_use
          DocumentSnapshot data = snapshot.data.docs[0];
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : Container(
            child: Info(
              documentSnapshot: data,
              // ignore: deprecated_member_use
              id: data.id,
              name: data['firstName'],
              phoneNumber: data['phoneNumber'],
              pinNumber: data['pin'],
              Address: data['address'],
            ),
          );
        },
      ),
    );
  }
}



class Info extends StatefulWidget {

  final String name;
  final String phoneNumber;
  final String pinNumber;
  final String Address;
  final String id;
  final DocumentSnapshot documentSnapshot;
  Info({
    @required this.name,
    @required this.documentSnapshot,
    @required this.id,
    @required this.phoneNumber,
    @required this.pinNumber,
    @required this.Address,
  });

  @override
  _InfoState createState() => _InfoState();
}
String id;
TextEditingController firstNameController = TextEditingController();
TextEditingController secondNameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController pinNumberController = TextEditingController();
TextEditingController addressController = TextEditingController();
String FirstName;
String SecondName;
String PhoneNumber;
String PINNumber;
String address;

class _InfoState extends State<Info> {


  @override
  int count=1;
  bool ispress=true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("𝕭𝖆𝖌",style: TextStyle( fontFamily: 'Raleway',fontSize: 30,color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Container(
//          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/7,
              ),
              Container(
//        color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.deepOrange),
                    ),
//                color: Colors.white70,
                  elevation: 10,
                    child: InkWell(
                      splashColor: Colors.deepOrange,
                      onTap: (){},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/2.5,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height/2.5/1.6,
                              // Firebase code of showing.........................................................
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(widget.name ?? 'null',style: TextStyle(fontFamily: 'Raleway',fontSize: 20),),
                                    subtitle:Text(widget.phoneNumber ?? 'null'),
                                  ),
                                  ListTile(
                                    title: Text(widget.pinNumber),
                                    subtitle: Text(widget.Address),
                                  )

                                ],
                              )
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
//                            color: Colors.orange,
                              child: ListTile(
                                title: Text("Add new Address",style: TextStyle(fontFamily: 'Raleway',color: Colors.blueAccent),),
                                subtitle: Text("You can add new Address",),
                                leading: IconButton(
                                  icon: Icon(Icons.add_circle_outline,size: 30,),
                                  onPressed: (){
                                    count++;
                                    if(count%2==0)
                                    {
                                      ispress=false;    // showing previous Address
                                    }else
                                      ispress=true;

                                    setState(() {
                                      _widget(ispress);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _widget(ispress),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _widget(bool ispress)
{

  print(ispress);
  if(ispress==true)
    return Button();
  return FORMS();
}

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>  {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.white),
            ),
            onPressed: (){},
            child: const Text('👉🏻👉🏻 Continue to payment', style: TextStyle(fontFamily: 'Raleway',fontSize: 18)),
            color: Colors.deepOrange,
            textColor: Colors.white,
            elevation: 5,
          ),
        ),
      ),
    );
  }
}


class FORMS extends StatefulWidget {
  @override
  _FORMSState createState() => _FORMSState();
}

class _FORMSState extends State<FORMS> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipient First Name'
                    ),
                    validator: (value)
                    {
                      if (value.isEmpty) {
                        return 'Please enter first Name';
                      }
                      return null;
                    },
                    onChanged: (value)
                    {
                      FirstName=value;
                    },
                    controller: firstNameController,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipient Last Name'
                    ),
                    validator: (value)
                    {
                      if (value.isEmpty) {
                        return 'Please enter last Name';
                      }
                      return null;
                    },
                    onChanged: (value)
                    {
                      SecondName=value;
                    },
                    controller: secondNameController,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipient Phone Number'
                    ),
                    validator: (value)
                    {
                      if (value.length!=10) {
                        return 'Please enter valid  Number';
                      }
                      return null;
                    },
                    onChanged: (value)
                    {
                      PhoneNumber=value;
                    },
                    controller: phoneNumberController,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PIN Number'
                    ),
                    validator: (value)
                    {
                      if (value.length!=6) {
                        return 'Please enter valid PIN';
                      }
                      return null;
                    },
                    onChanged: (value)
                    {
                      PINNumber=value;
                    },
                    controller: pinNumberController,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address Line 1'
                    ),
                    validator: (value)
                    {
                      if (value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                    onChanged: (value)
                    {
                      address=value;
                    },
                    controller: addressController,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address Line 2'
                    ),

                  ),
                  SizedBox(height: 14,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Colors.deepOrange,
                        child: Text("Save",style: TextStyle(fontFamily: 'Raleway',color: Colors.white,fontSize: 20),),
                        onPressed: (){
                          if(_formKey.currentState.validate())
                          {
                            uploadingData(FirstName, SecondName, PhoneNumber, PINNumber,address);
//                            Navigator.of(context).pop();
                          }
                          clearText();
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
    );
  }
}
void clearText() {
  firstNameController.clear();
  secondNameController.clear();
  pinNumberController.clear();
  phoneNumberController.clear();
  addressController.clear();
}