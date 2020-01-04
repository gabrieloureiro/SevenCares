import 'package:flutter/material.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/screens/main/home.dart';
import 'package:flutter_app/screens/main/login.dart';
import 'package:flutter_app/undefinedView.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff37474f),
  accentColor: Color(0xff546e7a),
  //fontFamily: "TitilliumWeb"
);

void main() => runApp(MaterialApp(
  title: "Seven Cares",
  home: Login(),
  theme: temaPadrao,
  initialRoute: "/",
  onGenerateRoute: Routes.generateRoutes,
  debugShowCheckedModeBanner: false,
));
