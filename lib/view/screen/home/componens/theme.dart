import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),

    ),
    iconTheme: IconThemeData(color: Colors.black),);


  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      // iconTheme: TextTheme(
      //   headline6: TextStyle(color: Colors.white, fontSize: 18),
      // ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
