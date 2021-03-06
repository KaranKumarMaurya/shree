import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  var signupcollections = FirebaseFirestore.instance.collection('users');

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User users =  FirebaseAuth.instance.currentUser;
    assert(user.uid == users.uid);

    print('signInWithGoogle succeeded: $user');

    // ignore: deprecated_member_use
    signupcollections.doc(users.uid).collection('signup').add({
            'FullName': user.displayName,
            'Email': user.email,
            'MobileNo': "9084XXXXXX",
            'DOB': "17/0X/XXXX"
    });

   return '$user';
  }

  return null;

}

signOutGoogle() {
  googleSignIn.signOut();
  print("User Signed Out");
  

}