import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sgj/Harshit/services/authtentication.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignupPage> {

  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  //Input Holder and clear input
  final nameHolder = TextEditingController();
  final emailHolder = TextEditingController();
  final mobileHolder = TextEditingController();
  final passwordHolder = TextEditingController();

  //Focus Node for input fields
  FocusNode emailFocusNode;
  FocusNode mobileFocusNode;
  FocusNode passwordFocusNode;

  _State(
      {this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction
      });

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

  //Form input value variable
  String registerName = "";
  String registerEmail = "";
  String registerMobile = "";
  String registerPassword = "";

  //Code for create new user account

  void submitForm() async {
    String createAccountFeedback =
        await createAccount(registerEmail, registerPassword, registerMobile, registerName);
    if (createAccountFeedback != null) {
      _alertDialogBuilder(createAccountFeedback);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    emailFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    mobileFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  //Function for clear field start code from here
  clearTextInput() {
    nameHolder.clear();
    emailHolder.clear();
    mobileHolder.clear();
    passwordHolder.clear();
  }
  //Function for clear field code ends here

  final _key = GlobalKey<FormState>();
  final _key1 = GlobalKey<FormState>();
  final _key2 = GlobalKey<FormState>();
  final _key3 = GlobalKey<FormState>();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    Pattern pattern1 = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regex1 = new RegExp(pattern1);

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
            color: Color(0xFF594E4E),
            fontSize: 7.0,
            fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(fontFamily: 'Raleway',
            color: Color(0xFF594E4E),
            fontSize: 19.0,
            fontWeight: FontWeight.w600));

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: (screenheight) / 45),
            child: ListView(
              children: <Widget>[
                //Name Container
                Container(
                  padding: EdgeInsets.fromLTRB(
                      screenwidth / 45, screenheight / 45, screenwidth / 45, 0),

                  /*************************** Full Name Text Field Code statrs from here *********************************/

                  //Theme widget use for changing icon color on focus
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _key,
                    child: Theme(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Name is required";
                          } else {
                            return null;
                          }
                        },
                        controller: nameHolder,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          registerName = value;
                        },
                        onTap: () {
                          emailFocusNode.requestFocus();
                        },
                        textInputAction: TextInputAction.next,

                        //Code for permanent border and focused border in text field
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline),
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
                  //Theme widget use for changing icon color on focus code ends here
                ),
                //Name Container Ends Here

                /*************************** Full Name Text Field Code ends here *********************************/

                /*************************** Email Text Field Code statrs from here *********************************/

                //email Container start from here
                Container(
                  padding: EdgeInsets.fromLTRB(
                      screenwidth / 45, screenheight / 45, screenwidth / 45, 0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _key1,
                    child: Theme(
                      child: TextFormField(
                        validator: (String value) {
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
                          registerEmail = value;
                        },

                        onTap: () {
                          mobileFocusNode.requestFocus();
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
                //email container ends here

                /*************************** Email Text Field Code ends here *********************************/

                /*************************** Mobile Text Field Code statrs from here *********************************/

                //mobile Container start from here
                Container(
                  padding: EdgeInsets.fromLTRB(
                      screenwidth / 45, screenheight / 45, screenwidth / 45, 0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _key2,
                    child: Theme(
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Mobile number is required";
                          } else if (!regex1.hasMatch(value)) {
                            return "Invalid mobile number";
                          } else {
                            return null;
                          }
                        },
                        controller: mobileHolder,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          registerMobile = value;
                        },

                        onTap: () {
                          passwordFocusNode.requestFocus();
                        },

                        // focusNode: mobileFocusNode,

                        textInputAction: TextInputAction.next,

                        //Code for permanent border and focused border in text field
                        decoration: InputDecoration(
                          hintText: 'Mobile No.',
                          prefixIcon: Icon(Icons.phone),
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
                //mobile container ends here

                /*************************** Mobile Text Field Code ends here *********************************/

                /*************************** Password Text Field Code statrs from here *********************************/

                //Password Container
                Container(
                  padding: EdgeInsets.fromLTRB(
                      screenwidth / 45, screenheight / 45, screenwidth / 45, 0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _key3,
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
                        onChanged: (value) {
                          registerPassword = value;
                        },

                        // focusNode: passwordFocusNode,

                        onTap: () {
                          // submitForm();
                        },

                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        textAlignVertical: TextAlignVertical.center,
                        //Code for permanent border and focused border in text field
                        decoration: InputDecoration(
                          hintText: 'Password',
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
                //Password Container Ends Here

                /*************************** Password Text Field Code ends here *********************************/

                /*************************** Sign up button Code statrs from here *********************************/

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFFFF5C00),
                        child: Text(
                          'Sign Up',
                          style: new TextStyle(fontFamily: 'Raleway',fontSize: 17),
                        ),
                        onPressed: () {
                          // submitForm();
                          if (_key.currentState.validate() &&
                              _key1.currentState.validate() &&
                              _key2.currentState.validate() &&
                              _key3.currentState.validate()) {
                            pr.show();
                            Future.delayed(Duration(seconds: 5)).then((value) {
                              pr.hide().whenComplete(() {
                                 submitForm();
                              });
                            });
                          }
                        },
                      )),
                ),

                /*************************** Sign up button Code ends here *********************************/

                /*************************** Go to login screen Code statrs from here *********************************/

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            'Already have an account? ',
                            style: TextStyle(fontFamily: 'Raleway',fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              'Log In',
                              style: TextStyle(fontFamily: 'Raleway',
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
                                  builder: (context) => LoginPage()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                  ],
                ),
              ],
            )));
  }
}
