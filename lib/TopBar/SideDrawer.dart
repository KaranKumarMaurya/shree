import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgj/Bamal/FAQ.dart';
import 'package:sgj/Bamal/Drawer.dart';
import 'package:sgj/Harshit/widgets/call-email-widget.dart';
import 'package:sgj/Harshit/widgets/service_locator.dart';
import 'package:sgj/Harshit/widgets/call-whatsapp-lanuch.dart';
import 'package:sgj/Bamal/Drawer.dart';
import 'package:sgj/Harshit/widgets/sign_in_facebook.dart';
import 'package:sgj/Harshit/widgets/sign_in_google.dart';
import 'package:sgj/components/HomePage/product_display_grid.dart';

class SideDrawer extends StatelessWidget {
  // final String title;
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final String email = "abc@gmail.com";
  final String number = "1234567890";
  @override
  Widget build(BuildContext context) {
    final String email = "test@gmail.com";
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    final small_padding = (MediaQuery.of(context).size.height) / 100;
    return SafeArea(
      child: Drawer(
        child: ListView(children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductDisplayGrid(name: "ring")));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey)),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                      height: screen_width / 16,
                      width: screen_width / 8,
                      child: SvgPicture.network(
                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/Bangles.svg?alt=media&token=e36c72bd-cf2c-43b8-b1b5-46ee4bbd4094")),
                  Container(
                    child: Text(
                      "   Jewellery Category 1",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductDisplayGrid(name: "bangle")));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                      height: screen_width / 16,
                      width: screen_width / 8,
                      child: SvgPicture.network(
                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/earrings.svg?alt=media&token=e7d985e6-b814-4728-bc8c-eb82dab72efb")),
                  Container(
                    child: Text(
                      "   Jewellery Category 2",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductDisplayGrid(name: "necklace")));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                      height: screen_width / 16,
                      width: screen_width / 8,
                      child: SvgPicture.network(
                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/silverjewellery.svg?alt=media&token=6697870f-fe00-45b8-9a53-67858fe330b4")),
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Silver Jewellery Store",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductDisplayGrid(name: "ring")));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Container(
                        height: screen_width / 12,
                        width: screen_width / 8,
                        child: SvgPicture.network(
                            "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/newarrivals.svg?alt=media&token=41bf53b3-b22d-4b21-82dd-f5c07432b230")),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "New Arrivals",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 3.0, bottom: 3.0),
                    child: Text(
                      "NEW!",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.orange,
                          fontStyle: FontStyle.italic,
                          fontSize: 8),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => FAQ()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                      height: screen_width / 12,
                      width: screen_width / 8,
                      child: SvgPicture.network(
                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/faq1.svg?alt=media&token=ff8d1e6d-f3de-4468-8463-251e66ce1158")),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, bottom: 5),
                    child: Text(
                      "FAQ's",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
              child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 2.0, color: Colors.grey),
                    right: BorderSide(width: 2.0, color: Colors.grey),
                    bottom: BorderSide(width: 2.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 6.0, 6.0),
            child: Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Container(
                        height: screen_width / 8,
                        width: screen_width / 8,
                        child: SvgPicture.network(
                            "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/help1.svg?alt=media&token=cf45ef87-bfab-4323-8842-f931ec25ac04")),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Need Help?",
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, top: 8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () =>
                                  launchWhatsApp(phone: "+919084439795"),
                              child: Container(
                                child: SvgPicture.asset("assets/whatsapp.svg",
                                    fit: BoxFit.fill,
                                    height: screen_width / 12,
                                    width: screen_width / 12),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                            child: InkWell(
                              onTap: () => _service.call(number),
                              child: Container(
                                child: SvgPicture.network(
                                    "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/phone.svg?alt=media&token=8f720f1f-44d4-49f6-ae25-934b940b3397",
                                    fit: BoxFit.fill,
                                    height: screen_width / 14,
                                    width: screen_width / 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                      height: screen_width / 12,
                      width: screen_width / 8,
                      child: SvgPicture.network(
                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/trackorder.svg?alt=media&token=4df41f75-f146-4c6c-9d28-9688b81fa84e")),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, bottom: 5),
                    child: Text(
                      "Track Order",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => _service.sendEmail(email),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                      height: screen_width / 12,
                      width: screen_width / 8,
                      child: SvgPicture.network(
                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/sendfeedbackmail.svg?alt=media&token=b7cadebe-3d79-4596-b703-11542d952344")),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, bottom: 5),
                    child: Text(
                      "Send Feedback Mail",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
              child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 2.0, color: Colors.grey),
                    right: BorderSide(width: 2.0, color: Colors.grey),
                    bottom: BorderSide(width: 2.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 6.0, 6.0),
            child: Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Container(
                        height: screen_width / 8,
                        width: screen_width / 8,
                        child: SvgPicture.network(
                            "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/followuson.svg?alt=media&token=d89ec250-c3bc-4f8f-b56f-72eb00205d2b")),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Follow Us On",
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, top: 8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: SvgPicture.network(
                                  "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/yt.svg?alt=media&token=d2e0e909-42d2-440e-8e71-4f50834dc0ab",
                                  fit: BoxFit.fill,
                                  height: screen_width / 10,
                                  width: screen_width / 10),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                            child: Container(
                              child: SvgPicture.network(
                                  "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/fb.svg?alt=media&token=be3bcd0b-0e08-44d1-8292-5fc152a86bc9",
                                  fit: BoxFit.fill,
                                  height: screen_width / 10,
                                  width: screen_width / 10),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                            child: Container(
                              child: SvgPicture.network(
                                  "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/ig.svg?alt=media&token=8aada295-6f73-4975-848b-d5c45e922abf",
                                  fit: BoxFit.fill,
                                  height: screen_width / 10,
                                  width: screen_width / 10),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                      height: screen_width / 12,
                      width: screen_width / 8,
                      child: SvgPicture.network(
                          "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/myaccount.svg?alt=media&token=04369f5b-a8ba-4145-9361-232a1eceaa6d")),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, bottom: 5),
                    child: Text(
                      "My Account",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              signOutGoogle();
              facebookLoginout();
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2.0, color: Colors.grey),
                      right: BorderSide(width: 2.0, color: Colors.grey),
                      bottom: BorderSide(width: 2.0, color: Colors.grey))),
              padding: EdgeInsets.all(16.0),
              child: Row(
                //LogOut Functionality, KK
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.exit_to_app,
                    size: 35,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, bottom: 5),
                    child: Text(
                      " LOG OUT",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
