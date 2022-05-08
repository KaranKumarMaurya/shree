import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReplicateProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _prodRef =
        FirebaseFirestore.instance.collection("Products");
    return FutureBuilder(
      future: _prodRef.get(),
      builder: (context, snapshot) {
        Map<String, dynamic> productData = snapshot.data.data();
        return ElevatedButton(
          onPressed: () {
            for (int i = 0; i < 10; i++) {
              print("Loop is Running");
              FirebaseFirestore.instance
                  .collection("Products")
                  .doc(snapshot.data.docs[i].id)
                  .update({
                'specifications.customizable.size': snapshot.data.docs[i]
                    .data()["specifications"]["size"]["default"]
              });
            }
          },
        );
      },
    );
  }
}
