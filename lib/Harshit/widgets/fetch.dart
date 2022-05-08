import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgj/Harshit/widgets/sign_in_facebook.dart';
import 'package:sgj/Harshit/widgets/sign_in_google.dart';

class FetchPage extends StatefulWidget {
  final String uid;

  FetchPage({Key key, @required this.uid}) : super(key: key);

  @override
  _FetchPageState createState() => _FetchPageState(uid);
}

class _FetchPageState extends State<FetchPage> {
  final String uid;
  _FetchPageState(this.uid);

  var taskcollections = FirebaseFirestore.instance.collection('users');
  String task;

  void showdialog(bool isUpdate, DocumentSnapshot ds) {


    showDialog(
        context: context,
        builder: (context) {
          return Container(

          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fetch Data",
          style: TextStyle(
            fontFamily: "tepeno",
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: (){
                FirebaseAuth.instance.signOut();
                signOutGoogle();
                facebookLoginout();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            // ignore: deprecated_member_use
            .doc(uid)
            .collection('signup')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              // ignore  deprecated_member_use
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                // ignore: deprecated_member_use
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      ds['Email'],
                      style: TextStyle(
                        fontFamily: "tepeno",
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    onLongPress: () {
                      // delete
                      taskcollections
                          // ignore: deprecated_member_use
                          .doc(uid)
                          .collection('task')
                          // ignore: deprecated_member_use
                          .doc(ds.id)
                          .delete();
                    },
                    onTap: () {
                      // == Update
                      showdialog(true, ds);
                    },
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
    );
  }
}
