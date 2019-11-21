import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_app/feed.dart';
import 'package:flutter_app/fitness.dart';
import 'package:flutter_app/newsletter.dart';
import 'package:flutter_app/profile.dart';
import 'package:flutter_app/search.dart';
import 'package:flutter_app/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:url_launcher/url_launcher.dart';
// ESSA TELA VAI SER A HOME -- FALTA CRIAR UMA MAIN COM LOGIN
void main() => runApp(Home());

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Firestore.instance
      .collection("users")
      .document("shape")
      .setData({"Gabriel": "Fitness"});
    return MaterialApp(
      title: "Seven Cares",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
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
            // IconButton(
            //   icon: Icon(MdiIcons.settings),
            //   tooltip: "Settings",
            //   iconSize: 33,
            //   color: Colors.grey,
            //   alignment: Alignment.centerRight,
            //   onPressed: (){
            //     Navigator.push(context,
            //       MaterialPageRoute(
            //         builder: (context) => Settings()
            //       ),
            //     );
            //     print("Settings active");
            //   },
            // ),

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
                title: Text("Desenvolvedor"),
                trailing: Icon(MdiIcons.githubCircle),
                onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => Settings()
                  ),
                );
                print("Developer active");
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

//CONTEÚDO DA TELA
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
     
// BARRA DE NAVEGAÇÃO INFERIOR
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
 

