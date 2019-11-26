import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/login.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff37474f),
  accentColor: Color(0xff546e7a)
);

void main() => runApp(MaterialApp(
  title: "Seven Cares",
  home: Home(),
  theme: temaPadrao,
  initialRoute: "/",
  onGenerateRoute: Routes.generateRoutes,
  debugShowCheckedModeBanner: false,
));
