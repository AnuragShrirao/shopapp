import 'package:flutter/material.dart';

class CityProvider extends ChangeNotifier {
  String _selectedCity="Amravati";
   get cityName {
     return _selectedCity;
   }
  Future<void> swapCity(String name) async{
    if (name == "Amravati") {
      _selectedCity = "Amravati";
    } else {
      _selectedCity = "Morshi";
    }
    notifyListeners();
  }

}
