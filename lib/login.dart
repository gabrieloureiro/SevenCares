import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/size_config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _erroMessage = '';
  bool _obscureText = true;
   void _passwordText(){
    setState(() {
      _obscureText = ! _obscureText;
    });
  }
  
  _validateFields(){
    String email = _controllerEmail.text;
    String password = _controllerSenha.text;

    //VALIDACAO DOS CAMPOS
     if(email.isNotEmpty && email.contains("@") && !email.contains(" ")){

        if(password.isNotEmpty){

          User user = User();
          user.email = email;
          user.password = password;
          
          _userLogin(user);
          _erroMessage = '';
        }else{
          setState(() {
            _erroMessage = "A senha deve conter 6 ou mais caracteres";
          });
        }

      }else{
        setState(() {
          _erroMessage = "Endereço de e-mail inválido ou já utilizado";
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
       Navigator.pushReplacementNamed(context, "/inicio"); 
      }).catchError((e){
        _erroMessage = "Erro ao autenticar usuário! Verifique o e-mail e a senha";
      });
    }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                      "images/logo-s7.png",),
                ),
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
                      prefixIcon: const Icon(
                        Icons.alternate_email,
                        color: Colors.black54,
                      )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)
                      ),
                      prefixIcon: IconButton(
                            icon : Icon(_obscureText ? Icons.remove_red_eye : Icons.panorama_fish_eye),
                            color: Colors.black45,
                            onPressed: _passwordText,
                      ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                        "Entrar",
                      style: TextStyle(color: Colors.white, 
                      fontSize: SizeConfig.blockSizeHorizontal*4),
                    ),
                      color: Color(0xff1ebbd8),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      onPressed: (){
                        _validateFields();
                      }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "Não possui conta?\t",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      child: Text("Cadastre-se!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),  
                      ),
                    onTap: (){
                      Navigator.pushNamed(context, "/signup");
                    },
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
