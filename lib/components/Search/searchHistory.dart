
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgj/components/ProductPage/product_page.dart';

class searchHistory extends StatefulWidget {

  @override
  _searchHistoryState createState() => _searchHistoryState();
}

// all these search history,KK
class _searchHistoryState extends State<searchHistory> {
  var firestoreDB = FirebaseFirestore.instance.collection('SearchHistory').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestoreDB,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data.docs[index];
print(data.data());
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(productKey :data['id']) )),
                        child: Text(data['Name'],
                            style: TextStyle(fontFamily: 'Raleway',
                              color: Colors.deepPurple,
                              fontSize: 20,
                            ),
                            ),
                      ),
                      Icon(Icons.history),

                    ],
                  ),
                );
              }
          );
        }
    );
  }
}