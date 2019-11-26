import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);
 
  @override
  _FeedState createState() => _FeedState();
}
 
class _FeedState extends State<Feed> {
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
              Image.asset(
                "images/bg-7.jpg",
                fit: BoxFit.cover,
                height: double.maxFinite,
                width: double.maxFinite,
                alignment: Alignment.center,
              )
            ],            
    );
  }
}