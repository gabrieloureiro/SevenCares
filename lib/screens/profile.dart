import 'package:flutter/cupertino.dart';
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
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture.height(200),email&access_token=$token');
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


  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.grey],
              )
            ),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:40),
                ),
                _isLoggedIn ? CircleAvatar(
                  foregroundColor: Colors.blueAccent.shade400,
                  backgroundColor: Colors.lightBlueAccent,
                  backgroundImage: NetworkImage(userProfile["picture"]["data"]["url"]),
                    minRadius: 100,
                    maxRadius: 100,
                  child: GestureDetector(
                    onTap: (){
                      showDialog(
                        context : context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Alterar imagem de perfil"),
                              titleTextStyle: TextStyle(
                                color : Colors.lightBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top:25)
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left:30)
                                      ),
                                      IconButton(
                                        splashColor: Colors.lightBlueAccent.shade400,
                                        icon: Icon(MdiIcons.camera),
                                        iconSize: 70,
                                        color: Colors.black87,
                                        onPressed: (){
                                          // Navigator.push(context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => CameraMethod()
                                          //   ),
                                          // );
                                          print("Change image profile active [camera]");
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left:35),
                                      ),
                                      IconButton(
                                        splashColor: Colors.lightBlueAccent.shade400,
                                        icon: Icon(MdiIcons.folderImage),
                                        iconSize: 70,
                                        color: Colors.black87,
                                        onPressed: (){
                                          // Navigator.push(context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => GalleryMethod()
                                          //   ),
                                          // );
                                          print("Change image profile active [gallery]");
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),),
                              actions: <Widget>[
                                FlatButton(
                                  splashColor: Colors.lightBlueAccent.shade400,
                                  child: Text(
                                    "FECHAR",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                      );
                    }
                  ),
                )
                : CircleAvatar(
                  foregroundColor: Colors.lightBlueAccent.shade400,
                  backgroundColor: Colors.lightBlueAccent,
                  backgroundImage: ExactAssetImage('images/maleuser.png'),
                    minRadius: 100,
                    maxRadius: 100,
                  child: GestureDetector(
                    onTap: (){
                      showDialog(
                        context : context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Alterar imagem de perfil"),
                              titleTextStyle: TextStyle(
                                color : Colors.lightBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top:25)
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left:30)
                                      ),
                                      IconButton(
                                        icon: Icon(MdiIcons.camera),
                                        iconSize: 70,
                                        color: Colors.black87,
                                        splashColor: Colors.lightBlueAccent.shade400,
                                        onPressed: (){
                                          // Navigator.push(context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => CameraMethod()
                                          //   ),
                                          // );
                                          print("Change image profile active [camera]");
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left:35),
                                      ),
                                      IconButton(
                                        icon: Icon(MdiIcons.folderImage),
                                        iconSize: 70,
                                        color: Colors.black87,
                                        splashColor: Colors.lightBlueAccent.shade400,
                                        onPressed: (){
                                          // Navigator.push(context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => GalleryMethod()
                                          //   ),
                                          // );
                                          print("Change image profile active [gallery]");
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),),
                              actions: <Widget>[
                                FlatButton(
                                  splashColor: Colors.lightBlueAccent.shade400,
                                  child: Text(
                                    "FECHAR",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                      );
                    }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:20),
                ),
                _isLoggedIn ? Text(userProfile["name"],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                  ),
                )
                : Text("Seven Cares User",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:22),
                ),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:25),
                  ),
                  Text("Nível",
                    style: TextStyle(
                      color : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:55),
                  ),
                  Container(
                    width: 180,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(                   
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.fromLTRB(6,0,0,0),
                            child: Row( 
                              children: <Widget>[
                              _isLoggedIn ? IconButton(
                                  icon: Icon(MdiIcons.logout),
                                  iconSize: 40,
                                  color: Colors.blueAccent.shade400,
                                  splashColor: Colors.blueAccent.shade400,
                                  onPressed: (){
                                    showDialog(
                                      context : context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Deseja sair do Facebook?"),
                                            titleTextStyle: TextStyle(
                                              color : Colors.lightBlue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                splashColor: Colors.lightBlueAccent.shade400,
                                                child: Text(
                                                  "DESCONECTAR",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                                onPressed: () { 
                                                  _logout();
                                                  Navigator.of(context).pop();
                                                  }
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left:20),
                                              ),
                                              FlatButton(
                                                splashColor: Colors.lightBlueAccent.shade400,
                                                child: Text(
                                                  "CANCELAR",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right:10),
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  }
                                )
                                  :IconButton(
                                    icon: Icon(MdiIcons.facebookBox),
                                    iconSize: 40,
                                    color: Colors.blueAccent.shade400,
                                    splashColor: Colors.blueAccent.shade400,
                                    onPressed: ()=> _loginWithFB(),
                                  ),
                                  IconButton(
                                    icon: Icon(MdiIcons.instagram),
                                    iconSize: 40,
                                    color: Colors.pinkAccent,
                                    splashColor: Colors.lightBlueAccent.shade400,
                                    onPressed: () {
                                      // _loginWithFB();
                                    },
                                  ),
                                  IconButton(
                                    icon: Image.asset("images/google.png"),
                                    iconSize: 40,
                                    color: Colors.red,
                                    splashColor: Colors.lightBlueAccent.shade400,
                                    onPressed: () {
                                      // _loginWithFB();
                                    },
                                  )
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:27),
                ),
                Text("Medalhas",
                    style: TextStyle(
                      color : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:38),
                  ),
                  Text("7",//CONTATOR DE EXPERIENCIA
                    style: TextStyle(
                      color : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:302),
                  ),
                  Text("77",//CONTADOR DE MEDALHAS
                    style: TextStyle(
                      color : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left:30),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom:410),
                  ),
                    IconButton(
                      icon: Image.asset("images/chart.png"),
                      iconSize: 60,
                      tooltip: "Avaliação Física",
                      color: Colors.blueGrey.shade400,
                      splashColor: Colors.lightBlueAccent.shade400,
                      onPressed: () {
                        // _loginWithFB();
                      },
                    ),
                    Text("Avaliação Física",
                      style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(bottom:15),
                  ),
                  IconButton(
                    icon: Image.asset("images/checkin.png"),
                    iconSize: 65,
                    tooltip: "Check-in",
                    color: Colors.grey,
                    splashColor: Colors.lightBlueAccent.shade400,
                    onPressed: () {
                      // _loginWithFB();
                    },
                  ),
                  Text("Check-in",
                    style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left:171),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom:410),
                  ),
                  IconButton(
                    icon: Image.asset("images/goal2.png"),
                    iconSize: 61.5,
                    tooltip: "Metas",
                    color: Colors.grey,
                    splashColor: Colors.lightBlueAccent.shade400,
                    onPressed: () {
                      // _loginWithFB();
                    },
                  ),
                  Text("Metas",
                    style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom:15),
                  ),
                  IconButton(
                    icon: Image.asset("images/medal.png"),
                    iconSize: 65,
                    tooltip: "Conquistas",
                    color: Colors.grey,
                    splashColor: Colors.lightBlueAccent.shade400,
                    onPressed: () {
                      // _loginWithFB();
                    },
                  ),
                  Text("Conquistas",
                    style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:30),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom:412),
                      ),
                      IconButton(
                        icon: Image.asset("images/ribbon.png"),
                        iconSize: 60,
                        tooltip: "Itens Salvos",
                        splashColor: Colors.lightBlueAccent.shade400,
                        color: Colors.grey,
                        onPressed: () {
                          // _loginWithFB();
                        },
                      ),
                      Text("Itens Salvos",
                        style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom:20),
                      ),
                      IconButton(
                        icon: Image.asset("images/car.png"),
                        iconSize: 60,
                        tooltip: "Estacionamento",
                        splashColor: Colors.lightBlueAccent.shade400,
                        color: Colors.grey,
                        onPressed: () {
                          // _loginWithFB();
                        },
                      ),
                      Text("Estacionamento",
                        style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}