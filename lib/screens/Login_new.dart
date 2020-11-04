import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/componenets/auth.dart';
import 'package:shopapp/componenets/constant.dart';
import 'package:shopapp/componenets/loading.dart';
import 'package:shopapp/screens/home_page.dart';
import 'package:shopapp/screens/registration.dart';
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
            // afasdas
            // second
            // third
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: ()async{
                  if(!await authProvider.signIn()){
                    _key.currentState.showSnackBar(SnackBar(
                      content: Text("LogIn failed !"),
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
                  child: Center(child: Text("LogIn",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                ),
              ),
            ),
            InkWell(child: Text("Register Here",style: TextStyle(fontWeight: FontWeight.bold),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration(),),);
            },
            ),
          ],
        ),
      ),
    );
  }
}
