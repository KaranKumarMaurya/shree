import 'package:flutter/material.dart';
import 'package:sgj/components/HomePage/product_display_grid.dart';
//import 'package:sgj/Bamal/pages/practice.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
              ),
            ),
            ProductDisplayGrid(),
          ],
        ),
      )
    );
  }
}
