import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:url_launcher/url_launcher.dart';
// ESSA TELA VAI SER A HOME -- FALTA CRIAR UMA MAIN COM LOGIN
void main() => runApp(Home());

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

// _launchURL(String url) async {
//   String url1 = url;
//   if (await canLaunch(url1)) {
//     await launch(url1);
//   } else {
//     throw 'Could not launch $url1';
//   }
// }

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
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
          IconButton(
            icon: Icon(MdiIcons.settings),
            tooltip: "Settings",
            iconSize: 38,
            color: Colors.grey,
            alignment: Alignment.centerRight,
            onPressed: (){
              // Navigator.push(context,
              //   MaterialPageRoute(
              //     builder: (context) => Settings()
              //   ),
              // );
              print("Settings active");
                },
              ),
        ],
          ),

//CONTEÚDO DA TELA
          body: Stack(
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
              )
            ],
          ),
     
// BARRA DE NAVEGAÇÃO INFERIOR
          bottomNavigationBar: BottomAppBar(
            color: Colors.black87,
            child: Row(
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.fromLTRB(32, 10, 0, 5),
                  icon: Icon(Icons.library_books),
                  iconSize: 38,
                  color: Colors.grey,
                  tooltip: "Newsletter",
                  onPressed: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Newsletter()
                  //   ),
                  // );
                    
                    print("Newsletter active");
                  },
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(37, 10, 0, 5),
                  icon: Icon(Icons.search),
                  iconSize: 38,
                  color: Colors.grey,
                  tooltip: "Search",
                  onPressed: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Search()
                  //   ),
                  // );                   
                    print("Search active");
                  },
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(37, 10, 0, 5),
                  icon: Image.asset(
                    "images/seven-small.png",
                    width: 60,
                    height: 60,
                  ),
                  iconSize: 48,
                  color: Colors.grey,
                  tooltip: "Feed Seven Cares active",
                  onPressed: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Feed()
                  //   ),
                  // );
                    print("Feed Seven Cares active");
                  },
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(37, 10, 0, 5),
                  icon: Icon(Icons.fitness_center),
                  iconSize: 38,
                  color: Colors.grey,
                  tooltip: "Record Training active",
                  onPressed: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Fitness()
                  //   ),
                  // );
                    print("Record Training active");
                  },
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(40, 10, 27.4, 5),
                  icon: Icon(MdiIcons.accountSettings),
                  iconSize: 39,
                  color: Colors.grey,
                  tooltip: "Profile",
                  onPressed: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Profile()
                  //   ),
                  // );
                    print("Profile active");
                  },
                ),
              ],
          ),
        )
    );
  }
}
 

