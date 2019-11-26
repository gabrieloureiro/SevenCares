import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);
 
  @override
  _SearchState createState() => _SearchState();
}
 
class _SearchState extends State<Search> {
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
              Text("Search test"),
            ],            
    );
  }
}