import 'package:flutter/material.dart';
import 'package:flutter_app/screens/forgotpassword.dart';
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
        break;
      case "/signup" :
        return MaterialPageRoute(
            builder: (_) => SingUp()
        );
        break;
      case "/inicio" :
        return MaterialPageRoute(
            builder: (_) => Home()
        );
        break;
      case "/login" : 
        return MaterialPageRoute(
          builder: (_) => Login()
        );
        break;
      case "/forgot" : 
        return MaterialPageRoute(
          builder: (_) => ForgotPassword()
        );
        break;
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