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
            child: Text(
              document['name'],
              style:Theme.of(context).textTheme.title,    
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              document['userType'],
              style: Theme.of(context).textTheme.subtitle,
            ),
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
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black87, Colors.grey],
                  )
                ),
                alignment: Alignment.topCenter,
              ),
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
                  return ListView.builder(
                    itemExtent: 80,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context,index)=>_buildListItem(context,snapshot.data.documents[index]),
                  );
                },
              )
            ],            
    );
  }
}