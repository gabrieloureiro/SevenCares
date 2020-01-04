import 'package:flutter/material.dart';
import 'package:flutter_app/screens/main/forgotpassword.dart';
import 'package:flutter_app/screens/main/home.dart';
import 'package:flutter_app/screens/main/login.dart';
import 'package:flutter_app/screens/main/signup.dart';
import 'package:flutter_app/undefinedView.dart';
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
        return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name,));
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