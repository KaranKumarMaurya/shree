import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgj/Harshit/widgets/call-email-widget.dart';
import 'package:sgj/Harshit/widgets/service_locator.dart';
import 'package:sgj/Harshit/widgets/sign_in_facebook.dart';
import 'package:sgj/Harshit/widgets/sign_in_google.dart';

class FeedbackEmail extends StatefulWidget {
  @override
  _FeedbackEmailState createState() => _FeedbackEmailState();
}

class _FeedbackEmailState extends State<FeedbackEmail> {

  final CallsAndMessagesService _service = locator<CallsAndMessagesService>(); 
  final String number = "123456789";
  final String email = "publicemail545@gmail.com";
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            RaisedButton(
              child: Text("Logout"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    signOutGoogle();
                    facebookLoginout();
                  }, 
            ),
            RaisedButton(
              child: Text(
                "call $number",
              ),
              onPressed: () => _service.call(number),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text(
                "Email $email",
              ),
              onPressed: () => _service.sendEmail(email),
            ),
          ],
        ),
      ),
    );
  }
}