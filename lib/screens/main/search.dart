import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);
 
  @override
  _SearchState createState() => _SearchState();
}
 
class _SearchState extends State<Search> {

  _launchURL(String url) async {
    String url1 = url;
    if (await canLaunch(url1)) {
      await launch(url1);
    } else {
      throw 'Não foi possível acessar $url1';
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ 
                Text(
                  document['name'],
                  style: TextStyle(
                    color : Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),    
                ),
                Text(
                  document['userType'],
                  style: TextStyle(
                    color : Colors.black87,
                    fontSize: 13,
                  ),    
                ),
              ],
            ),
          ),
          Padding (
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(document['imgUrl']),
                minRadius: 30,
                maxRadius: 30,
            )
          )
        ],
      ),
      onTap: (){
        showDialog(
          context : context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Padding(
                padding: EdgeInsets.fromLTRB(50,0,50,0),
                child: Text(document["name"],
                  style: TextStyle(
                    color : Colors.lightBlue,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:10),
                        ),
                        CircleAvatar(
                          backgroundImage:
                            NetworkImage(document['imgUrl']),
                          minRadius: 40,
                          maxRadius: 40,   
                        ),                  
                        Row(
                          children: <Widget>[
                            Text('Convidar para treinar'),
                          ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       colors: [Colors.black87, Colors.grey],
              //     )
              //   ),
              //   alignment: Alignment.topCenter,
              // ),
              StreamBuilder(
                stream: Firestore.instance.collection("user").snapshots(),
                builder: (context, snapshot){
                if(!snapshot.hasData) 
                  return const 
                    Text("Loading...",
                      style: TextStyle(
                        color : Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(height: 2, color: Colors.grey),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context,index)=>_buildListItem(context,snapshot.data.documents[index]),
                  );
                },
              )
            ],            
    );
  }
}