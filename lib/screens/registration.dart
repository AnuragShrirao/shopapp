import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/componenets/auth.dart';
import 'package:shopapp/componenets/constant.dart';
import 'package:shopapp/componenets/loading.dart';
import 'package:shopapp/screens/Login_new.dart';

import 'home_page.dart';
class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _key =GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: authProvider.status==Status.Authenticating?Loading():SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 100, 100, 50),
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F01.png?alt=media&token=bf9ad9c6-780a-4dd7-b011-c01bde326e9e"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                controller: authProvider.name,
                decoration: kInputDecoration.copyWith(
                  labelText: "Name",
                  hintText: "Enter Your Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: TextFormField(
                controller: authProvider.mob,
                decoration: kInputDecoration.copyWith(
                  hintText: "Enter Your Mob No.",
                  labelText: "Mobile No.",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: authProvider.email,
                decoration: kInputDecoration.copyWith(
                  labelText: "E-mail",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: TextFormField(
                controller: authProvider.password,
                decoration: kInputDecoration.copyWith(
                  hintText: "Enter Password",
                  labelText: "Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: ()async{
                  if(!await authProvider.signUp()){
                    _key.currentState.showSnackBar(SnackBar(
                      content: Text("Registration failed !"),
                    ),);
                    return;
                  }
                  authProvider.cleanController();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage(),),);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [
                          Colors.blue,Colors.lightBlueAccent,
                        ]
                    ),
                  ),
                  child: Center(child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                ),
              ),
            ),
            InkWell(child: Text("LogIn Here",style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn(),),);
              },
            ),
          ],
        ),
      ),
    );
  }
}
