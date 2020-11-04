import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/componenets/user.dart';
import 'package:shopapp/componenets/user_helper.dart';
enum Status{Uninitialized,Unauthenticated,Authenticating,Authenticated}

class  AuthProvider with ChangeNotifier{
  FirebaseAuth _auth;
  User _user;
  Status _status =Status.Uninitialized;
  UserServices _userServices=UserServices();
  UserModel _userModel;


  Status get status=>_status;
  UserModel get userModel=> _userModel;
  User get user=>_user;

  final formKey =GlobalKey<FormState>();

  TextEditingController email =TextEditingController();
  TextEditingController name =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController mob = TextEditingController();

  AuthProvider.initialize(): _auth=FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChange);
  }

  Future <bool> signIn() async{
    try{
      _status=Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    }
    catch(e){
      _status=Status.Unauthenticated;
      notifyListeners();
      print("error "+e.toString(),);
      return false;

    }
  }

  Future <bool> signUp()async{
    try{
      _status=Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((user){
        Map<String,dynamic> values={
          "name":name.text,
          "email": email.text,
          "id":user.user.uid,
          "time":DateTime.now().toString(),
          "mob":mob.text,
        };
        _userServices.createUser(values);
      });
      return true;
    }
    catch(e){
      _status=Status.Unauthenticated;
      notifyListeners();
      print("error : "+e.toString(),);
      return false;
    }
  }

  Future signOut(){
    _auth.signOut();
    _status=Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void cleanController(){
    email.text='';
    password.text='';
    name.text='';
    mob.text='';
  }

  Future<void> _onStateChange(User firebaseUser)async{
    if(firebaseUser==null){
      _status=Status.Uninitialized;
    }
    else{
      _user = firebaseUser;
      _status=Status.Authenticated;
      _userModel=await _userServices.getUserById(firebaseUser.uid);
    }
    notifyListeners();
  }



}