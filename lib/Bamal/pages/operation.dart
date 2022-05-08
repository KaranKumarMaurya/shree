import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




Future<void> uploadingData(String _firstName, String _lastName,
    String _phoneNumber, String _pin, String _address) async {
  // ignore: deprecated_member_use
  await FirebaseFirestore.instance.collection("Address").add({
    'firstName': _firstName,
    'lastName': _lastName,
    'phoneNumber': _phoneNumber,
    'pin': _pin,
    'address':_address,
  });
  print(" Function call");
}
