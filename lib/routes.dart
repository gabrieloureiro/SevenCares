import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/signup.dart';
import 'package:flutter_app/login.dart';
class Routes {

  static Route<dynamic> generateRoutes(RouteSettings settings){

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case "/signup" :
        return MaterialPageRoute(
            builder: (_) => SingUp()
        );
      case "/inicio" :
        return MaterialPageRoute(
            builder: (_) => Home()
        );
      case "/login" : 
        return MaterialPageRoute(
          builder: (_) => Login()
        );
      default:
        _routeError();
    }

  }

  static Route<dynamic> _routeError(){

    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title: Text("Tela não encontrada!"),),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );

  }

}