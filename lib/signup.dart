import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/size_config.dart';

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

  void _passwordText(){
    setState(() {
      _obscureText = ! _obscureText;
    });
  }

  _validateFields(){
    String name = _controllerNome.text;
    String email = _controllerEmail.text;
    String password = _controllerSenha.text;
    String confirmPassword = _controllerConfirmarsenha.text;
    String gender = "";
    //VALIDACAO DOS CAMPOS
    if(_isSelectedM == true){
      gender = "Masculino";
    }
    else if(_isSelectedF == true){
      gender = "Feminino";
    }

    if( name.isNotEmpty){

      if( email.isNotEmpty && email.contains("@")){

        if( password.isNotEmpty && password.length > 6 )  {

          if(password == confirmPassword){

          User user = User();
          user.name = name;
          user.email = email;
          user.password = password;
          user.userType = gender;

          _userSignUp( user );
          _erroMessage = '';
          }else{
            setState(() {
              _erroMessage = "Senhas não compatíveis";
            });
          }
        }else{
          setState(() {
            _erroMessage = "A senha deve conter mais de 6 caracteres";
          });
        }

      }else{
        setState(() {
          _erroMessage = "Utilize um e-mail válido";
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
              '/inicio', 
              (_) => false);
        

      }).catchError((e){
        _erroMessage = "Erro ao cadastrar usuario, verifique email e senha";
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _controllerNome,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
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
                      contentPadding: EdgeInsets.fromLTRB(15, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
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
                      contentPadding: EdgeInsets.fromLTRB(15, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
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
                      contentPadding: EdgeInsets.fromLTRB(15, 16, 32, 16),
                      hintText: "Confirmar senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                  obscureText: _obscureText,
                ),
                Padding(
                  padding : EdgeInsets.only(left: 70,right: 70),
                  child: FlatButton(
                  onPressed: _passwordText,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}