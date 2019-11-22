import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'developers.dart';
import 'feed.dart';
import 'fitness.dart';
import 'newsletter.dart';
import 'profile.dart';
import 'search.dart';
import 'settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class teste extends StatefulWidget {
  teste({Key key}) : super(key: key);
  @override
  _testeState createState() => _testeState();
}

_launchURL(String url) async {
  String url1 = url;
  if (await canLaunch(url1)) {
    await launch(url1);
  } else {
    throw 'Não foi possível acessar $url1';
  }
}

class _testeState extends State<teste> 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              "images/logo-s7.png",
              width: 108,
            ),
            backgroundColor: Colors.black87,
            centerTitle: true,

          actions: <Widget>[
          ],
        ),

        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text("Aluno SevenCares há 27 dias",),
                accountName: Text("Gabriel Loureiro",),
                currentAccountPicture: CircleAvatar(
                  child: Image.asset(
                    "images/seven-small.png",
                    alignment: Alignment.center,
                    width: 45,
                    height: 45,
                  ),
                  backgroundColor: Colors.black54,
                ),
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                    child: Image.asset(
                      "images/seven-small.png",
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                    ),
                  backgroundColor: Colors.black54,
                  ),
                ],
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black87, Colors.grey],
                  ) 
                ),
              ),
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
                title: Text("Desenvolvedores"),
                trailing: Icon(MdiIcons.githubCircle),
                onTap: (){
                  showDialog(
                    context : context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Desenvolvedores"),
                        titleTextStyle: TextStyle(
                          color : Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        content: SingleChildScrollView(
                          child: new ListBody(
                            children: <Widget>[
                              Row(
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
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "FECHAR",
                              style: TextStyle(
                                color: Colors.grey,
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
                  _launchURL("https://sevencares.com.br");
                },
              ),
              ListTile(
                title: Text("Sair"),
                trailing: Icon(MdiIcons.logoutVariant),
                onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => Settings()
                  ),
                );
                print("Logout active");
                },
              ),
            ],
          )
        ),

        body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Newsletter(),
                  Search(),
                  Feed(),
                  Fitness(),
                  Profile(),
                ],
              ),
     
          bottomNavigationBar: BottomAppBar(
            color: Colors.black87,
            child: TabBar(
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.library_books),
                      ),
                      Tab(
                        icon: Icon(Icons.search),
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
                        icon: Icon(MdiIcons.accountSettings),
                      ),
                    ],
                ),
          )
      );
  }
}
 

