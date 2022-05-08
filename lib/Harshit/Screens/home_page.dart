import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgj/Harshit/Screens/address-and-delivery.dart';
import 'package:sgj/Harshit/Screens/payment-gateway.dart';
import 'package:sgj/Harshit/Screens/track-order-screen.dart';
import 'package:sgj/Harshit/widgets/call-email-widget.dart';
import 'package:sgj/Harshit/widgets/call-whatsapp-lanuch.dart';
import 'package:sgj/Harshit/widgets/service_locator.dart';
import 'package:sgj/Harshit/widgets/sign_in_facebook.dart';
import 'package:sgj/Harshit/widgets/sign_in_google.dart';

class HarshitHomePage extends StatefulWidget {
  @override
  _HarshitHomePageState createState() => _HarshitHomePageState();
}

class _HarshitHomePageState extends State<HarshitHomePage> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final String number = "1234567890";
  final String email = "test@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  signOutGoogle();
                  facebookLoginout();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text(
                  "call $number",
                ),
                onPressed: () => _service.call(number),
              ),
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text(
                  "Whatsapp",
                ),
                onPressed: () => launchWhatsApp(phone: "+919084439795"),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text(
                  "Email $email",
                ),
                onPressed: () => _service.sendEmail(email),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text(
                  "Go to Payment Screen",
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PaymentScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text(
                  "Address & Delivery Section",
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Data();
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text(
                  "Track Order",
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TrackOrder();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
