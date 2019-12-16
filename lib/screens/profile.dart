import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_app/model/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
 
  @override
  _ProfileState createState() => _ProfileState();
}

Future _verifyUserLoggedIn() async{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser userLoggedIn = await auth.currentUser();
  Firestore db = Firestore.instance;
  if(userLoggedIn != null){
    db.collection('user')
    .document(userLoggedIn.uid);
  }
  return null;
}

class _ProfileState extends State<Profile> {
  
  File _image;

 

  @override
  void initState() { 
    super.initState();
  }

  Future _recuperarImagem(bool ofCamera) async {
    File _selectedImage;
    if(ofCamera == true){ //Imagem da camera
      _selectedImage = await ImagePicker.pickImage(
        source: ImageSource.camera,
      );
    }
    else { //Imagem da galeria
      _selectedImage = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );
    }
    setState(() {
      _image = _selectedImage;
    });
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference root = storage.ref();
    StorageReference file = root
    .child('profile_pictures')
    .child("profile1.jfif");
    file.putFile(_image);
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
        Text("Medalhas",
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

  Widget _alertDialogCamera(){
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
                  _recuperarImagem(true);
                  print("Change image profile active [camera]");
                  _uploadImage();
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
                  _recuperarImagem(false);
                  print("Change image profile active [gallery]");
                  _uploadImage();
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

  Widget _profileUp(){
    
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical*2.5,
          ),
          _image == null               
          ? CircleAvatar(
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
                      return _alertDialogCamera();
                    }
                );
              }
            ),
          )
          : CircleAvatar(
            foregroundColor: Colors.lightBlueAccent.shade400,
            backgroundColor: Colors.lightBlueAccent,
            backgroundImage: FileImage(_image),
              minRadius: 100,
              maxRadius: 100,
            child: GestureDetector(
              onTap: (){
                showDialog(
                  context : context,
                    builder: (BuildContext context) {
                      return _alertDialogCamera();
                    }
                );
              }
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical*2.5,
          ),
          StreamBuilder(
            stream:
                Firestore.instance.collection('user').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Text(
                snapshot.data.documents['uid']['name'],
                style: TextStyle(fontSize: 25.0),
              );             
          }), 
          SizedBox(
            height: SizeConfig.blockSizeVertical*2.5,
          ),
          _status(),
      ],  
    ),
  );
  }

  Widget _profileDown(){
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Image.asset("images/chart.png"),
                iconSize: SizeConfig.blockSizeHorizontal*10,
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
                fontSize: SizeConfig.blockSizeHorizontal*3,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical*4.5,
              ),
              IconButton(
                icon: Image.asset("images/checkin.png"),
                iconSize: SizeConfig.blockSizeHorizontal*10,
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
                fontSize: SizeConfig.blockSizeHorizontal*3
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical*4.5,
              ),
            ],
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Image.asset("images/goal2.png"),
                iconSize: SizeConfig.blockSizeHorizontal*10,
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
                fontSize: SizeConfig.blockSizeHorizontal*3
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical*4.5,
              ),                
              IconButton(
                icon: Image.asset("images/medal.png"),
                iconSize: SizeConfig.blockSizeHorizontal*10,
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
                fontSize: SizeConfig.blockSizeHorizontal*3
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical*4.5,
              ),
            ],
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Image.asset("images/ribbon.png"),
                iconSize: SizeConfig.blockSizeHorizontal*10,
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
                fontSize: SizeConfig.blockSizeHorizontal*3
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical*4.5,
              ),
              IconButton(
                icon: Image.asset("images/car.png"),
                iconSize: SizeConfig.blockSizeHorizontal*10,
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
                fontSize: SizeConfig.blockSizeHorizontal*3
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical*4.5,
                width: SizeConfig.blockSizeHorizontal*5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileCore(){
    return Stack(
      alignment: Alignment.topCenter,
        children: <Widget>[
          _profileUp(),
          _profileDown()
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    SizeConfig().init(context);
    return _profileCore();
    
  }
}