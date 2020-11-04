import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/componenets/auth.dart';
import 'package:shopapp/componenets/constant.dart';
import 'package:shopapp/componenets/user_helper.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile"),
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: kInputDecoration,
          ),
          RaisedButton(
            onPressed: (){
              Map<String,dynamic> values={
                "name":name.text,
                "id":Provider.of<AuthProvider>(context,listen: false).user.uid,
              };
              UserServices profile=UserServices();
              profile.updateData(values);

            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
