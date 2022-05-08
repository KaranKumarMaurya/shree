import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';

var facebookLogin = new FacebookLogin();

// ignore: deprecated_member_use
Future<User> facebookLogIn() async {
  // ignore: deprecated_member_use
  // FirebaseUser currentUser;
  var signupcollections = FirebaseFirestore.instance.collection('users');

  try {
    final FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(permissions: [
      FacebookPermission.email,
    ]);

    print('First Step done');
    if (facebookLoginResult.status == FacebookLoginStatus.success) {
      // FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      // ignore deprecated_member_use
      final AuthCredential credential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken.token);
      // ignore: deprecated_member_use
      final User user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      print('Second Step done');
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      User users = FirebaseAuth.instance.currentUser;
      assert(user.uid == users.uid);
      print("Done step");

      print("$user");
      // User users =  FirebaseAuth.instance.currentUser;
      // ignore: deprecated_member_use
      signupcollections.doc(users.uid).collection('signup').add({
        'FullName': user.displayName,
        'Email': user.email,
        'MobileNo': "9084XXXXXX",
        'DOB': "17/0X/XXXX",
      });
      return users;
    }
    print('Final Step done');
  } catch (e) {
    print('error caught: $e');
  }
}

Future<bool> facebookLoginout() async {
  await FirebaseAuth.instance.signOut();
  await facebookLogin.logOut();
  print("logout sucessfully");
  return true;
}
