import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* Class Name:
* Class Description:
* Inherited Class Name(s):
* Inherited Class Description:
*       - User Defined:
*       - System Defined:
* */

class ad_display extends StatelessWidget{
  final DocumentReference _adRef = FirebaseFirestore.instance.collection("Ad_Info").doc("qK1uabpCPFJTLMYtTF0C");

  @override/*
  * Method Name:  build
  * Parameters: BuildContext context
                ()
  * Inputs:
  * Output:
  * Error Handling:
  * Description:
   * */
  Widget build(BuildContext context) {

    final screen_height = MediaQuery.of(context).size.height;
    Future<DocumentSnapshot> pro = _adRef.get();
    final screen_width = MediaQuery.of(context).size.width;
            return Padding(
              padding: const EdgeInsets.only(top : 20.0, bottom: 20.0 ),
              child: Container(
                height : screen_height/2.2,         // Explain Here only
                width: screen_width,
                child : FutureBuilder<DocumentSnapshot>(
                  future: pro,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return Image.network("${data['Image']}",
                      fit: BoxFit.fill,
                      );
                    }
                    else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator()); // By default, show a loading spinner.
                  },
                )


              ),
            );


  }


}
