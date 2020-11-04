import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme;
  ThemeData light = ThemeData.light().copyWith(
    primaryColor: Colors.lightBlueAccent,
  );
  ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
  );
  ThemeProvider({bool isDarkMode}){
    this._selectedTheme= isDarkMode ? dark : light;
  }
  Future<void> swapTheme() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      preferences.setBool('isDarkTheme', false);
    } else {
      _selectedTheme = dark;
      preferences.setBool('isDarkTheme', true);
    }
    notifyListeners();
  }
  ThemeData get getTheme=>_selectedTheme;
}
