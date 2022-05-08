import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sgj/Harshit/Screens/login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ForgotPassword> {
  final Function(String) onChanged;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final emailHolder = TextEditingController();

  _State(
      {this.onChanged});

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  String email = "";

Future<String> resetPassword(String email) async {
  try{

    await _firebaseAuth.sendPasswordResetEmail(email: email);
    
    Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      if(e.code == 'email-not-exist')
      {
        return 'This email address not exists';
      }
      return e.message;
    } catch (e){
      return e.toString();
    }
    clearTextInput();
    return "Mail has been sent";
}

  Future<void> submitForm(String emails) async {

    String loginFeedback = await resetPassword(emails);
    if(loginFeedback != null) {
      _alertDialogBuilder(loginFeedback);
    }
    else{
      _alertDialogBuilder("Mail has been sent");
      clearTextInput();
      Navigator.pop(context);
    }
  }

  clearTextInput() {
    emailHolder.clear();
 
  }

  final _key = GlobalKey<FormState>();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Wait...',
        borderRadius: 4.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(fontFamily: 'Raleway',
            color: Color(0xFF594E4E), fontSize: 7.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(fontFamily: 'Raleway',
            color: Color(0xFF594E4E), fontSize: 19.0, fontWeight: FontWeight.w600));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password",
            style: TextStyle(fontFamily: 'Raleway',
              color: Color(0xFF0B0086),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (){
               Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => LoginPage()),
               );
            },
          ),
          titleSpacing: 1,
          backgroundColor: Colors.white,
        ),
        body: Padding(
            padding: EdgeInsets.only(top: (screenheight) / 45),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 15),
                  child: Container(  
                    child: Text("Password Assistance",
                    style: TextStyle(fontFamily: 'Raleway',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ),
                ),
                //Forogt Password above text start from here
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 30),
                  child: Container(
                   child: Text(
                    "Enter the email address associated with your Shree Ganga Jewellers account.",
                    style: TextStyle(fontFamily: 'Raleway',
                      fontSize: 18,
                    ),
                  ),
                  ),
                ),
                //Forgot password above text code ends here


                //Email Container code start from here
                Container(
                  padding: EdgeInsets.fromLTRB((screenwidth) / 45,
                      (screenheight) / 45, (screenwidth) / 45, 0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _key,
                    child: Theme(
                      child: TextFormField(
                        
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email is required";
                          }else if(!regex.hasMatch(value)){
                            return "Invalid email address";
                          } else {
                            return null;
                          }
                        },
                        controller: emailHolder,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        textInputAction: TextInputAction.done,

                        //Code for permanent border and focused border in text field
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            borderSide: BorderSide(color: Color(0xFFABA0A0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            borderSide: BorderSide(color: Color(0xFFFF5C00)),
                          ),

                          //Error Outline Border
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            borderSide: BorderSide(color: Color(0xFFE53935)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            borderSide: BorderSide(color: Color(0xFFFF5C00)),
                          ),
                        ),
                        //Ends here
                      ),
                      data: Theme.of(context)
                          .copyWith(primaryColor: Color(0xFFFF5C00)),
                    ),
                  ),

                ),
                //Email Container code ends here

                //Send mail button code start from here
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(
                          (screenwidth) / 45, 0, (screenwidth) / 45, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFFFF5C00),
                        child: Text(
                          'Send Mail',
                          style: new TextStyle(fontFamily: 'Raleway',fontSize: 17),
                        ),   
                        onPressed: () {
                          // submitForm(email);
                          if(_key.currentState.validate()){
                            pr.show();
                          Future.delayed(Duration(seconds: 5)).then((value) {
                            pr.hide().whenComplete(() {
                              submitForm(email);
                            });
                          });
                          }
                          
                        },
                      )),
                ),
                //Send mail button code ends here

              ],
            )));
  }

}
