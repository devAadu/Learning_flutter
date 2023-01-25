import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier{


  ThemeData? _themeData;
  ThemeData get getTheme => _themeData!;
  setTheme(ThemeData themeData){
       _themeData = themeData;
       notifyListeners();
  }

  ThemeNotifier(this._themeData);
}