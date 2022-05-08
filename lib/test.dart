import 'package:flutter/material.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}









// (widget.snapshot.data.data()["specifications"]["type"] == "gold") ?
// Row(
// children :
// [
// Container(
// height: screenWidth/7,
// child:
// Text("Gold Colour")
// ),
// Expanded(
// child: Container(
// height: screenWidth/7,
// child:
// ListView.builder(
// scrollDirection: Axis.horizontal,
// physics: NeverScrollableScrollPhysics(),
// itemCount: (widget.snapshot.data.data()["specifications"]["colour"]).length,
// itemBuilder: (context, int index){
// return Container(
// width: screenWidth/6 ,
// child: Text(capitalize("${widget.snapshot.data.data()["specifications"]["customizable"]["colour"][index]}")),
// );
// }
// )
// ),
// )
// ]
// ) :
// Row(
// children: [
//
// ],
// )