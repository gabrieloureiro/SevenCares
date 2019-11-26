// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Login2 extends StatefulWidget {
  Login2({Key key}) : super(key: key);
 
  @override
  _Login2State createState() => _Login2State();
}
 
class _Login2State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black87, Colors.grey],
                  )
                ),
                alignment: Alignment.topCenter,
              ),
              // >>> CONTEÚDO
              Text("Login test"),
            ],            
    );
  }
}