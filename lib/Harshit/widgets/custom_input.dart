import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final Function onChanged;
  final Function onSubmitted;
  final FocusNode focusNode;

  CustomInput({this.onChanged, this.onSubmitted, this.focusNode});

  @override
  Widget build(BuildContext context) {

    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return Container(
                  padding: EdgeInsets.fromLTRB(screenwidth/45, screenheight/45, screenwidth/45, 0),
                  child: TextField(
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                //Code for permanent border and focused border in text field
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        borderSide: BorderSide(color: Color(0xFFABA0A0)), 
                        ),
                        focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      borderSide: BorderSide(color: Color(0xFFFF5C00))
                    ),
                    ),
                //Ends here 

                  ),
                );
  }
}