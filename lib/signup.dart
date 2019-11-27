import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/size_config.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class SingUp extends StatefulWidget {
  SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerConfirmarsenha = TextEditingController();
  String _erroMessage = '';
  bool _obscureText = true;
  bool _isSelectedM = false;
  bool _isSelectedF = false;

  void toogle(){
    setState(() {
      _obscureText = ! _obscureText;
    });
  }

  _validateFields(){
    String name = _controllerNome.text;
    String email = _controllerEmail.text;
    String password = _controllerSenha.text;
    String confirmPassword = _controllerConfirmarsenha.text;
    String genre = "";

    //VALIDACAO DOS CAMPOS
    if(_isSelectedM == true){
      genre = "Masculino";
    }
    else if(_isSelectedF == true){
      genre = "Feminino";
    }

    if(name.isNotEmpty){

      if(email.isNotEmpty && email.contains("@") && !email.contains(" ")){

        if(password.isNotEmpty && password.length > 6)  {

          if(password == confirmPassword){

            if(genre.isNotEmpty){

              User usuario = User();
              usuario.name = name;
              usuario.email = email;
              usuario.password = password;
              usuario.userType = genre;

            _userSignUp( usuario );
            _erroMessage = '';
            }else{
              setState(() {
                _erroMessage = "Insira o seu gênero";
              });
            }
          }else{
            setState(() {
              _erroMessage = "As senhas não são compatíveis";
            });
          }
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

    }else{
      setState(() {
        _erroMessage = "Insira o seu nome";
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
              '/inicio', 
              (_) => false);
        

      }).catchError((e){
        _erroMessage = "Erro ao cadastrar usuario, verifique o email e a senha";
      });
    }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.black87,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.grey],
              )
            ),
          ),                
          Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom:32),
                      child: Image.asset("images/usuario.png",
                        width: SizeConfig.blockSizeHorizontal*15,
                        height: SizeConfig.blockSizeVertical*15,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    TextField(
                      controller: _controllerNome,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                          hintText: "Nome",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //NOME
                    TextField(
                      controller: _controllerEmail,
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                          hintText: "E-mail",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _controllerSenha,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                          hintText: "Senha",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)
                          )
                      ),
                      obscureText: _obscureText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _controllerConfirmarsenha,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                          hintText: "Confirmar senha",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)
                          )
                      ),
                      obscureText: _obscureText,
                    ),
                    Padding(
                      padding : EdgeInsets.only(left: 70,right: 70),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      onPressed: toogle,
                      child: Text(_obscureText ? "Mostrar senha" : "Esconder senha"),
                      ),
                    ),                 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.lightBlueAccent,
                          value: _isSelectedM, 
                          onChanged: (bool value){
                            setState(() {
                              _isSelectedM = value;
                              _isSelectedF = false;
                              if(_isSelectedM == false){
                                _isSelectedF = true;
                              }
                            });
                          },
                        ),
                        Text("Masculino",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal*3.3
                          ),
                        ),
                        Checkbox(
                          activeColor: Colors.lightBlueAccent,
                          value: _isSelectedF, 
                          onChanged: (bool value){
                            setState(() {
                              _isSelectedF = value;
                              _isSelectedM = false;
                              if(_isSelectedF == false){
                                _isSelectedM = true;
                              }
                            });
                          },
                        ),
                        Text("Feminino",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal*3.3
                          ),
                        ),
                      ],
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
                            if(_erroMessage != ''){
                              showDialog(
                                context : context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(_erroMessage),
                                      titleTextStyle: TextStyle(
                                        color : Colors.lightBlue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      content: Text("Por favor, corrija o campo e tente novamente."),
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
                                            if(_erroMessage == "As senhas não são compatíveis"){
                                              _controllerConfirmarsenha.text = "";
                                            }
                                            else if(_erroMessage == "A senha deve conter 6 ou mais caracteres"){
                                              _controllerConfirmarsenha.text = "";
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                            }
                          }
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}