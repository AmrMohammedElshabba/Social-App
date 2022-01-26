import 'package:flutter/material.dart';

import 'constans.dart';

ThemeData lightTheme() {
  return ThemeData(
      primarySwatch: Colors.grey,
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black54),
      textTheme: ThemeData.light().textTheme.copyWith(
        headline1: TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.w700),
        headline2: TextStyle(fontSize: 25, color: Colors.grey[700]),
        subtitle1: TextStyle(fontSize: 16,color:  Colors.grey[600]),
        subtitle2: TextStyle(fontSize: 14,color: Colors.blue),
        bodyText1: TextStyle(
              fontSize: 16.0,
              color: Colors.black
          ),
          bodyText2: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 100.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey));
}
ThemeData darkTheme() {
  return ThemeData(
      primarySwatch: Colors.grey,
      canvasColor: Colors.black87,
      backgroundColor: Colors.white10,
      appBarTheme: const AppBarTheme(
          color: Colors.white10,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: ThemeData.dark().textTheme.copyWith(
        headline1: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.w700),
        headline2: TextStyle(fontSize: 25, color: Colors.grey[500]),
        subtitle1: TextStyle(fontSize: 16,color:  Colors.grey[500]),
        subtitle2: TextStyle(fontSize: 14,color: Colors.blue),
        bodyText1: TextStyle(
            fontSize: 16.0,
            color: Colors.white
        ),
        bodyText2: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
      cardColor: Colors.white10,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white10,
          elevation: 100.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey));
}