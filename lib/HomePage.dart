

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'components/HomePage/adinfo.dart';
import 'components/HomePage/categories.dart';
import 'components/HomePage/product_display_grid.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Container(
        child:
        Column(
          children: [
            categories(),
            ad_display(),
            ProductDisplayGrid(),
            //   ProductPage(productKey : "BOYcC16PFoQXHnAgiHe3")
          ],
        ),
      )
    );
  }

}





