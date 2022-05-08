import 'package:cloud_firestore/cloud_firestore.dart';

class Operation{

  final String uid;

  Operation({this.uid});

  var signupcollections = FirebaseFirestore.instance.collection('users');

  Future<void> uploadingData(String _registerName, String _registerEmail,
    String _registerMobile) async {
  // await FirebaseFirestore.instance.collection("signup").add({
  //   'FullName': _registerName,
  //   'Email': _registerEmail,
  //   'MobileNo': _registerMobile,
  // });
  // ignore: deprecated_member_use
  return await signupcollections.doc(uid).collection('signup').add({
        'FullName': _registerName,
        'Email': _registerEmail,
        'MobileNo': _registerMobile,
        'DOB':"17/0X/XXXX",
 });
}

}

