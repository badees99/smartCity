import 'package:flutter/material.dart';

// Define your primary and secondary colors
MaterialColor primarySwatch = Colors.blue;

// Define your theme data
ThemeData appTheme = ThemeData(
  primarySwatch: primarySwatch,
  accentColor: Colors.red,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16.0, color: Colors.black),
    button: TextStyle(fontSize: 16.0, color: Colors.white),
  ),
);

// Export your theme data

