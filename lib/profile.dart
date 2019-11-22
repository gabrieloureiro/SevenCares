import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
 
  @override
  _ProfileState createState() => _ProfileState();
}
 
class _ProfileState extends State<Profile> {
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async{

    
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }

  _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
            children: <Widget>[ 
              _isLoggedIn ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Column(
                  children: <Widget>[
                    Image.network(
                      userProfile["picture"]["data"]["url"], 
                      height: 50.0, 
                      width: 50.0,
                    ),
                    Text(
                      userProfile["name"]
                    ),
                    OutlineButton( 
                      child: Text("Logout"), 
                      onPressed: (){
                      _logout();
                      },
                    )
                  ],
                ),
              )
              : Stack(
                children: <Widget>[
                  Container(
                    
                  ),
                  Container(
                    
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.fromLTRB(123,0,0,40),
                    child: Row( 
                      children: <Widget>[
                        IconButton(
                          icon: Icon(MdiIcons.facebookBox),
                          iconSize: 40,
                          color: Colors.blueAccent,
                          onPressed: () {
                            _loginWithFB();
                          },
                        ),
                        IconButton(
                          icon: Icon(MdiIcons.instagram),
                          iconSize: 40,
                          color: Colors.pinkAccent,
                          onPressed: () {
                            // _loginWithFB();
                          },
                        ),
                        IconButton(
                          icon: Icon(MdiIcons.google),
                          iconSize: 40,
                          color: Colors.red,
                          onPressed: () {
                            // _loginWithFB();
                          },
                        ),
                      ],
                    ),
                  )
              ],
            )
          ],
        ),
      )
    );
  }
}