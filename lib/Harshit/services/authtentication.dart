import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgj/Harshit/widgets/operation.dart';

Future<String> createAccount(String registerEmail, String registerPassword, String registerMobile, String registerName) async {
    try {
      
       User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmail, password: registerPassword)).user;
        
       await Operation(uid: user.uid).uploadingData(registerName, registerEmail, registerMobile);
      // clearTextInput();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }


  //Code for create new user account
  Future<String> loginAccount(String loginEmail, String loginPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmail, password: loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'password-not-match') {
        return 'Password is worng';
      } else if (e.code == 'email-not exists') {
        return 'Email is wrong';
      } else if (e.code == 'user-not-found')
      {
        return 'User not found';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }