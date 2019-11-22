import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/facebook.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
 
  @override
  _ProfileState createState() => _ProfileState();
}
 
class _ProfileState extends State<Profile> {
  @override
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
                    CircleAvatar(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.lightBlueAccent,
                      backgroundImage:
                      // NetworkImage('url'), //Deverá ser um imagem estática e mudar se vc upar a foto ou por fb
                        ExactAssetImage('images/gabriel.jfif'),
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
                                            iconSize: 50,
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
                                            icon: Icon(MdiIcons.folderImage),
                                            iconSize: 50,
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
                    Text("Gabriel Loureiro",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                      ),
                    ),
                    //CONTINUAÇÃO DO PERFIL
                  ],
                ),
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
                           Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => FB()
                            ),
                          );
                          print("Settings active");
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
    );
  }
}