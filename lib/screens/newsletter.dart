import 'package:flutter/material.dart';

class Newsletter extends StatefulWidget {
  Newsletter({Key key}) : super(key: key);
 
  @override
  _NewsletterState createState() => _NewsletterState();
}
 
class _NewsletterState extends State<Newsletter> {
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
              Text("Newsletter test"),
            ],            
    );
  }
}