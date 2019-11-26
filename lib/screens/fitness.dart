import 'package:flutter/material.dart';

class Fitness extends StatefulWidget {
  Fitness({Key key}) : super(key: key);
 
  @override
  _FitnessState createState() => _FitnessState();
}
 
class _FitnessState extends State<Fitness> {
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
              Text("Fitness test"),
            ],            
    );
  }
}