import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_app/model/size_config.dart';
import 'package:flutter/cupertino.dart';
import '../main/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings.dart';
import 'package:flutter_app/model/user.dart';
//import 'dart:io';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);
 
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  String _idUser;

  @override
  void initState() { 
    super.initState();
  }

  _launchURL(String url) async {
    String url1 = url;
    if (await canLaunch(url1)) {
      await launch(url1);
    } else {
      throw 'Não foi possível acessar $url1';
    }
  }

  Future<List<User>> _getData() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
        await db.collection("user").getDocuments();

    List<User> listUsers = List();
    for (DocumentSnapshot item in querySnapshot.documents) {

      var dados = item.data;

      User user = User();
      user.name = dados["name"];
      user.imgUrl = dados["imgUrl"];

      listUsers.add(user);
    }

    return listUsers;
  }

_logOutUser() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Login()
    )); 
  }  

  Widget _drawerRight(){
    return Drawer(
      child: ListView(
        children: <Widget>[
          // UserAccountsDrawerHeader(
          //   accountEmail: Text("Aluno SevenCares há 27 dias",),
          //   accountName: Text("Gabriel Loureiro",),
          //   currentAccountPicture: CircleAvatar(
          //     child: Image.asset(
          //       "images/seven-small.png",
          //       alignment: Alignment.center,
          //       width: 45,
          //       height: 45,
          //     ),
          //     backgroundColor: Colors.black54,
          //   ),
          //   otherAccountsPictures: <Widget>[
          //     CircleAvatar(
          //       child: Image.asset(
          //         "images/seven-small.png",
          //         alignment: Alignment.center,
          //         width: 20,
          //         height: 20,
          //       ),
          //     backgroundColor: Colors.black54,
          //     ),
          //   ],
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [Colors.black87, Colors.grey],
          //     ) 
          //   ),
          // ),
          ListTile(
            title: Text("Configurações"),
            trailing: Icon(MdiIcons.settingsOutline),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => Settings()
              ),
            );
            print("Settings active");
            },
          ),
          ListTile(
            title: Text("Suporte"),
            trailing: Icon(Icons.help_outline),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => Settings()
              ),
            );
            print("Help active");
            },
          ),
          ListTile(
            title: Text("Compartilhar"),
            trailing: Icon(Icons.share),
            onTap: () => _launchURL('url')
          ),
          ListTile(
            title: Text("Desenvolvedores"),
            trailing: Icon(MdiIcons.githubCircle),
            onTap: (){
              showDialog(
                context : context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Desenvolvedores"),
                    titleTextStyle: TextStyle(
                      color : Colors.lightBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left:10),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _launchURL("https://www.linkedin.com/in/gabrieloureiro/");

                                },
                                child: CircleAvatar(
                                  backgroundImage:
                                      ExactAssetImage('images/gabriel.jpeg'),
                                  minRadius: 40,
                                  maxRadius: 40,                     
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(35,50,0,0),
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
                        ],
                      ),
                    ),
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
                });
            },
          ),
          ListTile(
            title: Text("Website"),
            trailing: Icon(MdiIcons.web),
            onTap: (){
              _launchURL("http://sevencares.com.br");
            },
          ),
          ListTile(
            title: Text("Sair"),
            trailing: Icon(MdiIcons.logoutVariant),
            onTap: () => _logOutUser()
          ),
        ],
      )
    );
  }

  Widget _status(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: SizeConfig.blockSizeHorizontal*3,
        ),
        Column(
          children: <Widget>[                 
            Text("Nível",
              style: TextStyle(
                color : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("7",//CONTATOR DE EXPERIENCIA
              style: TextStyle(
                color : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal*10,
        ),
        Column(
          children: <Widget>[                 
            Text("Check-ins",
              style: TextStyle(
                color : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("777",//CONTATOR DE EXPERIENCIA
              style: TextStyle(
                color : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ), 
        // Container(
        //   alignment: Alignment.center,
        //   width: 180,
        //   height: 55,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.all(Radius.circular(15))
        //   ),
        //   child: Row(
        //     children: <Widget>[
        //       Container(                   
        //         alignment: Alignment.bottomCenter,
        //         padding: EdgeInsets.fromLTRB(6,0,0,0),
        //           child: Row( 
        //             children: <Widget>[
        //             IconButton(
        //                   icon: Icon(MdiIcons.facebookBox),
        //                   iconSize: 40,
        //                   color: Colors.blueAccent.shade400,
        //                   splashColor: Colors.blueAccent.shade400,
        //                   onPressed: (){}
        //                   //=> _loginWithFB(),
        //                 ),
        //                 IconButton(
        //                   icon: Icon(MdiIcons.instagram),
        //                   iconSize: 40,
        //                   color: Colors.pinkAccent,
        //                   splashColor: Colors.lightBlueAccent.shade400,
        //                   onPressed: () {
        //                     // _loginWithFB();
        //                   },
        //                 ),
        //                 IconButton(
        //                   icon: Image.asset("images/google.png"),
        //                   iconSize: 40,
        //                   color: Colors.red,
        //                   splashColor: Colors.lightBlueAccent.shade400,
        //                   onPressed: () {
        //                     // _loginWithFB();
        //                   },
        //                 )
        //               ],
        //       ),
        //     ),
        //  ],
    //   ),
    // ),
    SizedBox(
    width: SizeConfig.blockSizeVertical*3,
    ),
    Column(
      children: <Widget>[ 
        Text("Sequência",
          style: TextStyle(
            color : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text("77",//CONTATOR DE EXPERIENCIA
          style: TextStyle(
            color : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    ],
  );
  }

  Widget _profileUp(){
    
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical*2.5,
          ),
          FutureBuilder<List<User>>(
            future: _getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Text("Carregando..."),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  List<User> list = snapshot.data;
                  User usuario = list[1];
                  return CircleAvatar(
                    foregroundColor: Colors.lightBlueAccent.shade400,
                    backgroundColor: Colors.lightBlueAccent,
                    backgroundImage: NetworkImage(usuario.imgUrl),
                      minRadius: 100,
                      maxRadius: 100,
                  );
              }
              return null;
            }
          ),
        
          // FutureBuilder(
          //   future: _getUrlImg(),
          //   builder: (context, AsyncSnapshot<String> imgurl) {
          //     if (imgurl.hasData) {
          //       if (imgurl.connectionState == ConnectionState.done || imgurl.connectionState == ConnectionState.active){
          //         return CircleAvatar(
          //           foregroundColor: Colors.lightBlueAccent.shade400,
          //           backgroundColor: Colors.lightBlueAccent,
          //           backgroundImage: NetworkImage(imgurl.data),
          //             minRadius: 100,
          //             maxRadius: 100,
          //         );
          //       }
          //       else if (imgurl.connectionState == ConnectionState.waiting) {
          //         return Text('Carregando...',
          //           style: TextStyle(
          //               color : Colors.white,
          //               fontSize: 14,
          //               fontWeight: FontWeight.bold,
          //           ),
          //         );
          //       }
          //     }
          //     else {   
          //       return FutureBuilder(
          //         future: _getGender(),
          //         builder: (context, AsyncSnapshot<String> snapshot) {
          //           if (snapshot.connectionState == ConnectionState.done) {
          //             if (snapshot.hasData && snapshot.data == 'Masculino'){
          //               return CircleAvatar(
          //                 foregroundColor: Colors.lightBlueAccent.shade400,
          //                 backgroundColor: Colors.lightBlueAccent,
          //                 backgroundImage: ExactAssetImage('images/maleuser.png'),
          //                   minRadius: 100,
          //                   maxRadius: 100,
          //               );
          //             }
          //             else if (snapshot.hasData && snapshot.data == 'Feminino') {
          //               return CircleAvatar(
          //                 foregroundColor: Colors.lightBlueAccent.shade400,
          //                 backgroundColor: Colors.lightBlueAccent,
          //                 backgroundImage: ExactAssetImage('images/femaleuser.png'),
          //                   minRadius: 100,
          //                   maxRadius: 100,
          //               );
          //             }
          //           }
          //           else if (snapshot.connectionState == ConnectionState.waiting){
          //             return Text('Carregando...',
          //               style: TextStyle(
          //                   color : Colors.white,
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.bold,
          //               ),
          //             );
          //           }
          //           return null;
          //         },
          //       );
          //     }
          //     return null;
          //   }
          // ),
          SizedBox(
            height: SizeConfig.blockSizeVertical*2.5,
          ),
  //         FutureBuilder(
  //           future: _getName(),
  //           builder: (context, AsyncSnapshot<String> snapshotName) {
  //             if (snapshotName.hasData) {
  //               return Text(snapshotName.data,
  //                 style: TextStyle(
  //                   color : Colors.white,
  //                   fontSize: 17,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               );
  //             }
  //             else {
  //               return CircularProgressIndicator(
  //                 //backgroundColor: Color(0xff38c4d8),
  //                 backgroundColor: Colors.white,
  //               );
  //             }
  //           },
  //         ),
  //         SizedBox(
  //           height: SizeConfig.blockSizeVertical*2.5,
  //         ),
  //         _status(),
      ],  
    ),
  );
  }

  Widget _profileCore(){
    return Stack(
      alignment: Alignment.topCenter,
        children: <Widget>[
          _profileUp(),
      ],
    );
  }

  Widget _coreHome(){
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Image.asset(
          "images/logo-s7.png",
          width: 109,
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        actions: <Widget>[],
      ),
      endDrawer: _drawerRight(),
      body: _profileCore(),  
    );
  }

  @override
  Widget build(BuildContext context){
    SizeConfig().init(context);
    return _coreHome();
  }
}