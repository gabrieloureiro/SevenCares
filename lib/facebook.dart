import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class FB extends StatefulWidget {
  FB({Key key}) : super(key: key);
  @override
  _FBState createState() => _FBState();
}
 
class _FBState extends State<FB> {
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
                    OutlineButton( 
                      child: Text("Logout"), 
                      onPressed: (){
                      _logout();
                      },
                    ),
                  ],
                ),
              )
              : _loginWithFB(),
            ],
        ),
      ),
    );
  }
}
