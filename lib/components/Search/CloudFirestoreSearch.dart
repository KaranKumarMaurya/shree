

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgj/components/ProductPage/product_page.dart';
import 'package:sgj/components/Search/SearchResults.dart';
import 'package:sgj/components/Search/searchHistory.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  var searchController = TextEditingController();
  void initState(){
    super.initState();

   // searchController.text="Search...";
    searchController.addListener((){
      print({searchController.text});
      setState(() {
        name = searchController.text;
      });
    });
  }
  String name = "";
  String Xray="";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              searchController.clear();
            },
            child: IconButton(
                icon : Icon(
                  Icons.cancel,
                )
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(0.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Container(
          padding: EdgeInsets.all(0),
          child: TextField(
            controller: searchController,
            onChanged: (value){
              Xray=value;
            },
            onSubmitted: (value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResults(value: value) ));
            },
            decoration: InputDecoration(

              // prefixIcon: Icon(Icons.search),
            ),
            //  onChanged: (val) {
            //    setState(() {
            //      name = val;
            //    });
            //  },
          ),
        ),
      ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 350,
            child: Card(
              elevation: 7,
              child: Scrollbar(
                isAlwaysShown: true,
                thickness: 5,
                hoverThickness: 10,
                radius: Radius.circular(50),
                child: Xray==""?searchHistory():StreamBuilder<QuerySnapshot>(
                  stream: (name != "" && name != null)
                      ? FirebaseFirestore.instance
                      .collection('Products')
                      .where("searchKeywords", arrayContains: name)
                      .snapshots()
                      : FirebaseFirestore.instance.collection("Products").snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return InkWell(
                          onTap: (){
                            setState(() {});
                            Map<String,dynamic> value={'Name': data['Name'], 'id':data.id};
                            FirebaseFirestore.instance.collection('SearchHistory').add(value);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(productKey : data.id) ));
                          },
                          child:Card(
                            child: Row(
                              children: <Widget>[
                                Image.network(
                                  data['images'][0],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 25,
                                ),

                                Text(
                                  data['Name'],
                                  style: TextStyle(fontFamily: "Raleway",
                                      fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

              ),
            ),
          ),
        ],
      ),

    );
  }

}