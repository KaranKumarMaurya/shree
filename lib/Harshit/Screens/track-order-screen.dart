import 'package:flutter/material.dart';

class TrackOrder extends StatefulWidget {
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shree Ganga Jewellers",
          style: TextStyle(fontFamily: 'Raleway',
            color: Color(0xFF0B0086),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => ),
            //);
          },
        ),
        titleSpacing: 1,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Necklace\nFrom Geetanjali Collection",
              style: TextStyle(fontFamily: 'Raleway',
                color: Color(0xFF594E4E),
                fontSize: 18,
              ),
            ),
            Image.asset('assets/images/necklace-img.png',
                width: 80, height: 80, fit: BoxFit.fill)
          ],
        ),
      ),
    );
  }
}
