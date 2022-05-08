import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgj/Bamal/FAQ.dart';
import 'package:sgj/Bamal/pages/Account.dart';
import 'package:sgj/Bamal/pages/Address.dart';
import 'package:sgj/Bamal/pages/Offer.dart';
import 'package:sgj/components/Bag/Bag.dart';
import 'package:sgj/Bamal/pages/MyOrder.dart';
import 'package:sgj/Harshit/widgets/call-email-widget.dart';
import 'package:sgj/Harshit/widgets/service_locator.dart';
import 'package:sgj/Harshit/widgets/call-whatsapp-lanuch.dart';
import 'package:sgj/Harshit/widgets/sign_in_facebook.dart';
import 'package:sgj/Harshit/widgets/sign_in_google.dart';
import 'package:sgj/components/Search/CloudFirestoreSearch.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//  User user =  FirebaseAuth.instance.currentUser;

class _HomePageState extends State<HomePage> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final String email = "abc@gmail.com";
  final String number = "1234567890";

  // User user =  FirebaseAuth.instance.currentUser;
  PageController _pageController = PageController();
  List<Widget> _screens = [
    // Account()

    Profile(uid: FirebaseAuth.instance.currentUser.uid),
    Address(uid: FirebaseAuth.instance.currentUser.uid),
    //Offer(),
    MyOrders(),
  ];

  int _selectedindex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  void _itemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    final small_padding = (MediaQuery.of(context).size.height) / 100;

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      drawer: SafeArea(
        child: Drawer(
          child: ListView(children: [
            InkWell(
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
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Jewellery Category 1",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
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
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                        height: screen_width / 16,
                        width: screen_width / 8,
                        child: SvgPicture.network(
                            "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/earrings.svg?alt=media&token=e7d985e6-b814-4728-bc8c-eb82dab72efb")),
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Jewellery Category 2",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FAQ()));
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
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
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
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Raleway',
                          ),
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
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 8.0, 8.0, 8.0),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
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
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Raleway',
                          ),
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
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 8.0, 8.0, 8.0),
                              child: Container(
                                child: SvgPicture.network(
                                    "https://firebasestorage.googleapis.com/v0/b/sgj-bhavsagar.appspot.com/o/fb.svg?alt=media&token=be3bcd0b-0e08-44d1-8292-5fc152a86bc9",
                                    fit: BoxFit.fill,
                                    height: screen_width / 10,
                                    width: screen_width / 10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 8.0, 8.0, 8.0),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        // backgroundColor:Colors.green,
        title: Text(
          "Shree Ganga Jewellers",
          style: TextStyle(
            color: Color(0xFF0B0086),
            fontFamily: 'Raleway',
          ),
        ),
        titleSpacing: 1.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return CloudFirestoreSearch();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Bag()));
            },
          )
        ],
      ),
      // backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _itemTapped,
        backgroundColor: Colors.amberAccent,
        color: Colors.amber,
        height: 60,
        items: [
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
          // Address icon changed,KK
          Icon(Icons.add_location,
              size: 30, color: /*Color(0xFF0B0086)*/ Colors.white),
          // Icon(Icons.favorite, size: 30,color: Colors.white),
          Icon(Icons.bookmark_border, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}

// Search Functionality
