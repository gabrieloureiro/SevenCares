import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/model/user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../settings.dart';
import 'feed.dart';
import 'fitness.dart';
import 'newsletter.dart';
import 'profile.dart';
import 'search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "Seven Cares",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

_launchURL(String url) async {
  String url1 = url;
  if (await canLaunch(url1)) {
    await launch(url1);
  } else {
    throw 'Não foi possível acessar $url1';
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> 
  with SingleTickerProviderStateMixin {

  TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(
      length: 5, 
      vsync: this,
      initialIndex: 2
    );
  }

  // Future _verifyUserLoggedIn() async{
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   FirebaseUser userLoggedIn = await auth.currentUser();
  //   Firestore db = Firestore.instance;
  //   if(userLoggedIn != null){
  //     db.collection('user')
  //     .document(userLoggedIn.uid)
  //     .setData({});
  //   }
  // }


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

  Widget _bodyTabs(){
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Newsletter(),
        Search(),
        Feed(),
        Fitness(),
        Profile(),
      ],
    );
  }

  Widget _bottomTabs(){
    return BottomAppBar(
      elevation: 10,
      color: Colors.black87,
      child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  icon: Icon(CupertinoIcons.news_solid),
                ),
                Tab(
                  icon: Icon(MdiIcons.accountSearch),
                ),
                Tab(
                  icon: Image.asset(
                    "images/seven-small.png",
                    width: 40,
                    height: 40,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.fitness_center),
                ),
                Tab(
                  icon: Icon(CupertinoIcons.profile_circled),
                ),
              ],
      ),
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
      body: _bodyTabs(),  
      bottomNavigationBar: _bottomTabs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _coreHome();
  }
}
 

