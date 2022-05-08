import 'package:sgj/components/ProductPage/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SizeButton extends StatefulWidget {
  SizeButton({@required this.update, @required this.maxSize, @required this.minSize, @required this.currSize});
  final Function update;
  final int maxSize;
  final int minSize;
  final int currSize;
  @override
  _SizeButtonState createState() => _SizeButtonState();
}

class _SizeButtonState extends State<SizeButton> {
  int currentSize;
  var borderWidth;
  void initState()
  {
    currentSize = widget.currSize;
    borderWidth = 1.0;
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    print("CustomizeDEsign Successful");
    print(currentSize.toString());
    TextEditingController controller = new TextEditingController();
    controller.text = "${currentSize}";
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    return Padding(
      padding: const EdgeInsets.only(left : 10.0),
      child: Row(
        children: [
          Container(
            width: screenWidth/18,
            height: screenWidth/20,
            child: ElevatedButton(
              onPressed: (){
                if(currentSize > widget.minSize) {
                  currentSize = currentSize - 1;
                  setState(() {});
                  widget.update(currentSize, "size");
                }
              },
              style: ButtonStyle(
                // minimumSize: MaterialStateProperty.resolveWith<Size>(
                //     (Set<MaterialState> states){
                //       return Size((screenWidth/18),
                //         (screenWidth/20),
                //
                //       );
                //     }
                // ),
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                        (Set<MaterialState> states) {
                      return EdgeInsets.all(0.0);
                    }
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth / 30),
                        //    side: BorderSide(color: borderColour)
                      );
                    }
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states){
                      return Color.fromRGBO(196, 196, 196, 1.0);

                    }
                ),
              ),
              child: Icon(Icons.remove,
                color: Colors.black,
                size:  screenWidth/18,),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth/14,
              height: screenWidth/16,
              child: TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (value){
                  if(int.parse(value) < widget.minSize) {
                    widget.update(widget.minSize, "size");
                    setState(() {
                      currentSize = widget.minSize;
                    });
                  }
                  else if(int.parse(value) > widget.maxSize) {
                    widget.update(widget.maxSize, "size");
                    setState(() {
                      currentSize = widget.maxSize;
                    });
                  }
                  else {
                    widget.update(int.parse(value), "size");
                    setState(() {
                      currentSize = int.parse(value);
                    });
                  }
                },
                // autofocus: true,
                textDirection: TextDirection.ltr,
                controller: controller,
                maxLines: 1,
                maxLength: 2,
                maxLengthEnforced: true,
                style: TextStyle(
                  //  height: 3,
                  fontSize: 16,fontFamily: "Raleway",
                ),
                decoration : InputDecoration(
                  contentPadding: EdgeInsets.only(left:2.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                //     initialValue: (Specs.size).toString(),
              ),
            ),
          ),
          Container(
            width: screenWidth/18,
            height: screenWidth/20,
            child: ElevatedButton(
              onPressed: (){
                if(currentSize < widget.maxSize) {
                  currentSize = currentSize + 1;
                  setState(() {});
                  widget.update(currentSize, "size");
                }
              },
              style: ButtonStyle(
                // minimumSize: MaterialStateProperty.resolveWith<Size>(
                //     (Set<MaterialState> states){
                //       return Size((screenWidth/18),
                //         (screenWidth/20),
                //
                //       );
                //     }
                // ),
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                        (Set<MaterialState> states) {
                      return EdgeInsets.all(0.0);
                    }
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth / 30),
                        //    side: BorderSide(color: borderColour)
                      );
                    }
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states){
                      return Color.fromRGBO(196, 196, 196, 1.0);

                    }
                ),
              ),
              child: Icon(Icons.add,
                color: Colors.black,
                size: screenWidth/18,),
            ),
          )
        ],
      ),
    );
  }
}
