import 'package:flutter/material.dart';
class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Contact Us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            SizedBox(height: 5,),
            Text("Call us : 9423985196"),
            SizedBox(height: 5,),
            Text("email: helpetroplus@gmail.com"),
            SizedBox(height: 5,),
            Text("TERMS & CONDITIONS"),
          ],
        ),
      ),
    );
  }
}
