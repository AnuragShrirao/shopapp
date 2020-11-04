import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopapp/componenets/constant.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController=TextEditingController();

  String email;

  Future registerUser(String phone,BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: "+91"+phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential)async{
          Navigator.of(context).pop();
          UserCredential result=await _auth.signInWithCredential(credential);
          User user =result.user;
          if(user!=null)
          {
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(user:user,email: email,),),);
          }
          else
          {
            print("error");
          }
        },
        verificationFailed: (FirebaseAuthException exception){print(exception.message);},
        codeSent: (String verificationId,[int forceResendingToken]){
          showDialog(context: context,
              barrierDismissible: false,
              builder: (context){
                return AlertDialog(
                  title: Text("Give the Code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: ()async{
                        final code=_codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                        UserCredential result=await _auth.signInWithCredential(credential);
                        User user=result.user;
                        if(user!=null)
                        {
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(user:user,email: email,),),);
                        }
                        else
                        {
                          print("error");
                        }
                      },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network("https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F01.png?alt=media&token=bf9ad9c6-780a-4dd7-b011-c01bde326e9e",height: 100,width: 100,),
                  SizedBox(height: 150,),
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: kInputDecoration.copyWith(
                    ),
                    controller: _phoneController,
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    decoration: kInputDecoration,
                    onChanged: (value){
                      setState(() {
                        email=value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("Login"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        final phone=_phoneController.text.trim();
                        registerUser(phone, context);
                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
