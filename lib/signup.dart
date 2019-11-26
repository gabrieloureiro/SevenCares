import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SingUp extends StatefulWidget {
  SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _erroMessage = '';

  _validateFields(){
    String name = _controllerNome.text;
    String email = _controllerEmail.text;
    String password = _controllerSenha.text;
    //VALIDACAO DOS CAMPOS
     if( name.isNotEmpty ){

      if( email.isNotEmpty && email.contains("@")){

        if( password.isNotEmpty ){

          User usuario = User();
          usuario.name = name;
          usuario.email = email;
          usuario.password = password;

          _userSignUp( usuario );
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

    }else{
      setState(() {
        _erroMessage = "Preencha o Nome";
      });
    }
    //CADASTRANDO USUARIO NO FIREBASE
    

  }

  _userSignUp(User user){
      FirebaseAuth auth = FirebaseAuth.instance;
      Firestore db = Firestore.instance;
      auth.createUserWithEmailAndPassword( //pegando os dados 
        email: user.email,
        password: user.password,
      ).then((firebaseUser){ //.then para caso salvemos o user, salvar no bd
        db.collection('user').document(firebaseUser.user.uid). //colecao com usuarios
        setData(user.toMap()); //setdata -> dados que quero salvar
        Navigator.pushNamedAndRemoveUntil(
              context, 
              'inicio', 
              (_) => false);
        

      }).catchError((e){
        _erroMessage = "Erro ao cadastrar usuario, verifique email e senha";
      });
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _controllerEmail,
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
                //NOME
                TextField(
                  controller: _controllerNome,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome completo",
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
                        "Cadastrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                      color: Color(0xff1ebbd8),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){
                        _validateFields();
                      }
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