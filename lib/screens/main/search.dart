import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);
 
  @override
  _SearchState createState() => _SearchState();
}
 
class _SearchState extends State<Search> {

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
      onTap: (){},
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