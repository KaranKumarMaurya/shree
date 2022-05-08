import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgj/Harshit/Screens/login.dart';
import 'package:sgj/MyHomePage.dart';

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {

        //if snapshot has an error
        if(snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        //connection initialized
        if(snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              //if stram snapshot has an error
        if(streamSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${streamSnapshot.error}"),
            ),
          );
        }

        if(streamSnapshot.connectionState == ConnectionState.active) {
          //Get the user
          User user = streamSnapshot.data;

          //if user is null, then logged in
          if(user == null) {

            return LoginPage();
          }
          else {
               // User user =  FirebaseAuth.instance.currentUser;
              //  return FetchPage(uid: user.uid);
              return MyHomePage();
          }
        }

        //Connecting to firebase 
        return Scaffold(
          body: Center(
            child: Text(""),
          ),
        );
            },
          );
        }

        //Checking the auth state 
        return Scaffold(
          body: Center(
            child: Text(""),
          ),
        );
      },
      
    );
  }
}