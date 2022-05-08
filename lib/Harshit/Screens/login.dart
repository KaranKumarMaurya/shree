import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sgj/Harshit/Screens/Forgot_password_scrren.dart';
import 'package:sgj/Harshit/Screens/signup.dart';
import 'package:sgj/Harshit/services/authtentication.dart';
import 'package:sgj/Harshit/widgets/sign_in_facebook.dart';
import 'package:sgj/Harshit/widgets/sign_in_google.dart';
import 'package:sgj/MyHomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final _key = GlobalKey<FormState>();
  final _key1 = GlobalKey<FormState>();

  //Input Holder and clear input
  final emailHolder = TextEditingController();
  final passwordHolder = TextEditingController();
  //Focus Node for input fields
  FocusNode emailFocusNode;
  FocusNode passwordFocusNode;

  bool validate = false;

  _State(
      {this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction});

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

  String loginEmail = "";
  String loginPassword = "";

  void submitForm() async {
    String loginFeedback = await loginAccount(loginEmail, loginPassword);
    if (loginFeedback != null) {
      _alertDialogBuilder(loginFeedback);
    }
  }

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  //Function for clear field start code from here
  clearTextInput() {
    emailHolder.clear();
    passwordHolder.clear();
  }

  //Function for clear field code ends here

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
        progressTextStyle: TextStyle(
            fontFamily: 'Raleway',
            color: Color(0xFF594E4E),
            fontSize: 7.0,
            fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            fontFamily: 'Raleway',
            color: Color(0xFF594E4E),
            fontSize: 19.0,
            fontWeight: FontWeight.w600));

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: (screenheight) / 45),
            child: ListView(
              children: <Widget>[
                //Email Container

                Container(
                  padding: EdgeInsets.fromLTRB((screenwidth) / 45,
                      (screenheight) / 45, (screenwidth) / 45, 0),

                  /*************************** Email Text Field Code statrs from here *********************************/

                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _key,
                    child: Theme(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email is required";
                          } else if (!regex.hasMatch(value)) {
                            return "Invalid email address";
                          } else {
                            return null;
                          }
                        },
                        controller: emailHolder,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          loginEmail = value;
                        },
                        onTap: () {
                          emailFocusNode.requestFocus();
                        },
                        textInputAction: TextInputAction.next,

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

                /*************************** Email Text Field Code ends here *********************************/

                /*************************** Password Text Field Code statrs from here *********************************/

                //Password Container
                Container(
                  padding: EdgeInsets.fromLTRB((screenwidth) / 45,
                      (screenheight) / 45, (screenwidth) / 45, 0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _key1,
                    child: Theme(
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Password is required";
                          } else {
                            return null;
                          }
                        },
                        controller: passwordHolder,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {
                          loginPassword = value;
                        },
                        focusNode: passwordFocusNode,

                        onTap: () {
                          //submitForm();
                        },

                        textInputAction: TextInputAction.done,
                        //Code for permanent border and focused border in text field
                        decoration: InputDecoration(
                          hintText: 'Password',
                          errorText: validate ? "Password is required" : null,
                          prefixIcon: Icon(Icons.lock_outline),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            borderSide: BorderSide(color: Color(0xFFABA0A0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              borderSide: BorderSide(color: Color(0xFFFF5C00))),
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

                /*************************** Password Text Field Code ends here *********************************/

                /*************************** Forgot password text code statrs from here *********************************/

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        //forgot password screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      },
                      textColor: Color.fromRGBO(86, 82, 82, 1),
                      child: Text('Forgot Password?'),
                    ),
                  ],
                ),

                /*************************** Forgot password text code ends here *********************************/

                /*************************** Sign In button Code statrs from here *********************************/

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(
                        (screenwidth) / 45, 0, (screenwidth) / 45, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xFFFF5C00),
                      child: Text(
                        'Sign In',
                        style:
                            new TextStyle(fontFamily: 'Raleway', fontSize: 17),
                      ),
                      onPressed: () async {
                        //submitForm();
                        if (_key.currentState.validate() &&
                            _key1.currentState.validate()) {
                          // loginAccount();
                          pr.show();
                          await Future.delayed(Duration(seconds: 5))
                              .then((value) {
                            pr.hide().whenComplete(() {
                              submitForm();
                            });
                          });
                        }
                      },
                    )),

                /*************************** Sign In button Code ends here *********************************/

                /*************************** Code for divider statrs from here *********************************/

                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: Color(0xFF000000),
                            height: 36,
                          ),
                        )),
                        Text('OR'),
                        Expanded(
                            child: new Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Color(0xFF000000),
                            height: 36,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),

                /*************************** Code for divider ends here *********************************/

                /*************************** Login with google Code statrs from here *********************************/

                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        pr.show();
                        Future.delayed(Duration(seconds: 5)).then((value) {
                          pr.hide().whenComplete(() {
                            // submitForm();
                            signInWithGoogle().then((result) {
                              if (result != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MyHomePage();
                                    },
                                  ),
                                );
                              }
                            });
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFDC4E41),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: new Text(
                                  'Sign in with google',
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Color(0xFFDC4E41),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: new Image.asset(
                                    'assets/icons/google-symbol.png',
                                    height: 20,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /*************************** Login with google Code ends here *********************************/

                /*************************** Login with facebook Code statrs from here *********************************/

                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        pr.show();
                        Future.delayed(Duration(seconds: 5)).then((value) {
                          pr.hide().whenComplete(() {
                            facebookLogIn().then((result) {
                              if (result != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MyHomePage();
                                    },
                                  ),
                                );
                              }
                            });
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF3B5998),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: new Text(
                                  'Sign in with facebook',
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Color(0xFF3B5998),
                                  ),
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  'assets/icons/facebook.png',
                                  height: 20,
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /*************************** Login with facebook Code ends here *********************************/

                /*************************** Go to signup screen Code statrs from here *********************************/

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            'Does not have an account? ',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                color: Color(0xFFFF5C00),
                              ),
                            ),
                          ),
                          onTap: () {
                            //signup screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                  ],
                ),

                /*************************** Go to signup screen Code ends here *********************************/
              ],
            )));
  }
}
