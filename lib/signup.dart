import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/size_config.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

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

    if(name.isNotEmpty){

      if(email.isNotEmpty && email.contains("@") && !email.contains(" ")){

        if(password.isNotEmpty && password.length > 6)  {

          if(password == confirmPassword){

            if(gender.isNotEmpty){

              User user = User();
              user.name = name;
              user.email = email;
              user.password = password;
              user.gender = gender;

            _userSignUp( user );
            _erroMessage = '';
            }else{
              setState(() {
                _erroMessage = "Marque uma das opções";
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
    //CADASTRANDO user NO FIREBASE
    

  }

  _userSignUp(User user){
      FirebaseAuth auth = FirebaseAuth.instance;
      Firestore db = Firestore.instance;
      auth.createUserWithEmailAndPassword( //pegando os dados 
        email: user.email,
        password: user.password,
      ).then((firebaseUser){ //.then para caso salvemos o user, salvar no bd
        db.collection('user').document(firebaseUser.user.uid). //colecao com users
        setData(user.toMap()); //setdata -> dados que quero salvar
        Navigator.pushNamedAndRemoveUntil(
              context, 
              '/inicio', 
              (_) => false);
        

      }).catchError((e){
        _erroMessage = "Erro ao cadastrar user, verifique o email e a senha";
      });
    }
  
 
  Widget _nameField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("Nome",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: _controllerNome,
          autofocus: true,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
              hintText: "Insira seu nome",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),                 
              ),
              suffixIcon: Icon(
                Icons.account_circle,
                color: Color(0xff38c4d8)
              )
          ),
        ),
      ]
    );
  }


  Widget _emailField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("E-mail",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: _controllerEmail,
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
              hintText: "Insira seu e-mail",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              suffixIcon: Icon(
                Icons.alternate_email,
                color: Color(0xff38c4d8)
              )
          ),
        ),
          
      ],
    );
  }


  Widget _passwordField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child:  Text("Senha",
              style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 5,),
          TextField(
            controller: _controllerSenha,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                hintText: "Insira sua senha",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32)
                ),
                suffixIcon: IconButton(
                  icon : Icon(_obscureText ? LineAwesomeIcons.eye : LineAwesomeIcons.eye_slash),
                  color: Color(0xff38c4d8),
                  onPressed: _passwordText,
                ),
            ),
            obscureText: _obscureText,
          ),
      ],
    );
  }


  Widget _confirmPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child:  Text("Confirmar senha",
              style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
              ),
          ), 
        ),
        SizedBox(height: 5,),
        TextField(
            controller: _controllerConfirmarsenha,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
                hintText: "Insira novamente a senha",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32)
                ),
                suffixIcon: IconButton(
                  icon : Icon(_obscureText ? LineAwesomeIcons.eye : LineAwesomeIcons.eye_slash),
                  color: Color(0xff38c4d8),
                  onPressed: _passwordText,
                ),
            ),
            obscureText: _obscureText,
          ),  
      ],
    );
  }

  Widget _checkBox(){
    return 
      // CHECK BOX
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: CircularCheckBox(
          activeColor: Color(0xff38c4d8),
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
        ),
        Text("Masculino",
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal*3.3,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: CircularCheckBox(
          activeColor: Color(0xff38c4d8),
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
        ),
        Text("Feminino",
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal*3.3,
            fontWeight: FontWeight.bold,
            color: Colors.white

          ),
        ),
      ],
   
  
    );
  }

  Widget _signUpButton(){
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(
            "CADASTRAR",
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
                          splashColor: Color(0xff38c4d8),
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
    );
  }
   @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.black,
      ),
       body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
         child: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Stack(
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
            child: Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom:0),
                      child: Image.asset("images/user.png",
                        width: SizeConfig.blockSizeHorizontal*30,
                        height: SizeConfig.blockSizeVertical*15,
                        color: Color(0xff38c4d8),
                      ),
                    ),
                    //FIELD NOME
                    _nameField(),
                    SizedBox(
                      height: 10,
                    ),
                    //FIELD EMAIL
                    _emailField(),
                    SizedBox(
                      height: 10,
                    ),
                    //FIELD SENHA
                    _passwordField(),
                    SizedBox(
                      height: 10,
                    ),
                    //FIELD CONFIRMAR SENHA
                   _confirmPassword(),
                    SizedBox(
                      height: 15,
                    ),   
                    _checkBox(),              
                    

                    //BOTAO CADASTRAR
                    _signUpButton()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )
    )
    );
  }
}