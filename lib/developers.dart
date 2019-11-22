import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer extends StatefulWidget {
  Developer({Key key}) : super(key: key);

  @override
  _DeveloperState createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  _launchURL(String url) async {
  String url1 = url;
  if (await canLaunch(url1)) {
    await launch(url1);
  } else {
    throw 'Could not launch $url1';
  }
}
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
              Scaffold(
                appBar: AppBar(
                  title: Image.asset(
                    "images/logo-s7.png",
                    width: 108,
                  ),
                  backgroundColor: Colors.black87,
                  centerTitle: true,
                ),
                body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _launchURL("https://www.linkedin.com/in/gabrieloureiro/");

                        },
                        child: CircleAvatar(
                          backgroundImage:
                              ExactAssetImage('images/gabriel.jfif'),
                          minRadius: 40,
                          maxRadius: 40,                     
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL("https://www.linkedin.com/in/daviximenes/");
      
                        },
                        child: CircleAvatar(
                          backgroundImage: ExactAssetImage('images/davi.jfif'),
                          minRadius: 40,
                          maxRadius: 40,
                        ),
                      ),
                    ],
                  ),
                )
                ],
            )
          )
          )
            ],
    );
                      
  }
}