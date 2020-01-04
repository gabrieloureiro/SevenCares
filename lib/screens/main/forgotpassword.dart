import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart'; 
import '../../model/size_config.dart';
class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}
//to do respota para o usuario de reset da senha
class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _controllerEmail = TextEditingController();
  String _erroMessage = "";

  

  _forgotPassword(User user){ 
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.setLanguageCode("pt-br");
      auth.sendPasswordResetEmail(
        email: user.email,
      ).then((firebaseUser){
        Navigator.pushNamed(context, "/login");
        
      }).catchError((e){
        _erroMessage = "E-mail invalido";
      });
  }
  _validateFields(){
    String email = _controllerEmail.text;

    //VALIDACAO DOS CAMPOS
     if(email.isNotEmpty && email.contains("@") && !email.contains(" ")){

          User user = User();
          user.email = email;
          _forgotPassword(user);
          _erroMessage = '';
      
      }else{
        setState(() {
          _erroMessage = "Endereço de e-mail inválido";
        });
      }
    


  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Scaffold(
          appBar: AppBar(
            title: Text("Recuperar senha",),
            backgroundColor: Colors.black87,
          ),
          body: Container( 
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.grey],
              )
            ),       
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                controller: _controllerEmail,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                  hintText: "E-mail",
                  filled: true,
                  fillColor: Colors.white,
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                                
                    ),
                    suffixIcon: const Icon(
                      Icons.alternate_email,
                      color: Color(0xff38c4d8),
                    )
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 10),
                child: RaisedButton(
                  child: Text(
                      "RECUPERAR",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: SizeConfig.blockSizeHorizontal*4,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                    ),
                  ),
                    color: Color(0xff38c4d8),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: (){
                      _validateFields();
                    }
                ),
              ),
            ], 
          ),
        ),
        )
      ],
    );
  }
}

