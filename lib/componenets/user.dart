

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UserModel extends ChangeNotifier{
  static const NAME ='name';
  static const EMAIL ='email';
  static const ID ='id';
  static const TIME ="time";
  static const MOB ="mob";


  String _name;
  String _email;
  String _id;
  String _time;
  String _mob;


  String get time => _time;
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get mob => _mob;



  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name=snapshot.data()[NAME];
    _email=snapshot.data()[EMAIL];
    _id=snapshot.data()[ID];
    _time=snapshot.data()[TIME];
    _mob=snapshot.data()[MOB];
  }


}