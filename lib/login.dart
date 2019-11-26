import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _erroMessage = '';
  
  _validateFields(){
    String email = _controllerEmail.text;
    String password = _controllerSenha.text;

    //VALIDACAO DOS CAMPOS
     if( email.isNotEmpty ){

        if( password.isNotEmpty ){

          User user = User();
          user.email = email;
          user.password = password;
          
          _userLogin(user);
          _erroMessage = '';
        }else{
          setState(() {
            _erroMessage = "Preencha a senha! digite mais de 6 caracteres";
          });
        }

      }else{
        setState(() {
          _erroMessage = "Preencha o E-mail válido";
        });
      }
    //LOGANDO USUARIO NO FIREBASE
   

  }
  _userLogin(User user){
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      ).then((firebaseUser){
       Navigator.pushReplacementNamed(context, "inicio"); 
      }).catchError((e){
        _erroMessage = "Erro ao autenticar usuario verifique email e senha";
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/fundo.png"),
              fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                      "images/logo-s7.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                TextField(
                  controller: _controllerEmail,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "e-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                        "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                      color: Color(0xff1ebbd8),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){

                      }
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                        "Não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/signup");
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                        _erroMessage,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
