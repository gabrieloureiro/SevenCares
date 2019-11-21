import 'package:flutter/material.dart';
//import 'package:flutter_app/main.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);
 
  @override
  _SettingsState createState() => _SettingsState();
}
 
class _SettingsState extends State<Settings> {
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
                  centerTitle: true,
                  backgroundColor: Colors.black87,
                  // leading: IconButton(
                  //   icon: Icon(Icons.arrow_back),
                  //   iconSize: 33,
                  //   color: Colors.grey,
                  //   tooltip: "Return",
                  //   onPressed: (){
                  //     Navigator.push(context,
                  //       MaterialPageRoute(
                  //         builder: (context) => HomeScreen()
                  //       ),
                  //     );
                  //     print("Settings active");
                  //   },
                  //),
                ),
              ),
              // >>> CONTEÚDO
            ],            
    );
  }
}