import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/size_config.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:video_player/video_player.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  VideoPlayerController _controllerVideo;
  String _errorMessage = '';
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

        if(password.isNotEmpty && !password.contains(" ")){

          User user = User();
          user.email = email;
          user.password = password;
          
          _userLogin(user);

          _errorMessage = '';

        }else{
          setState(() {
            _errorMessage = "A senha deve conter 6 ou mais caracteres";
          });
        }

      }else{
        setState(() {
          _errorMessage = "Endereço de e-mail inválido ou já utilizado";
        });
      }
   

  }
  _userLogin(User user){
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      ).then((firebaseUser){
       Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomeScreen())
      ); 
      }).catchError((e){
        _errorMessage = "Erro ao autenticar usuário! Verifique o e-mail e a senha";
      });
    }

    Future _verifyUserLoggedIn() async{
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseUser userLoggedIn = await auth.currentUser();
      if(userLoggedIn != null){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeScreen())
        );
      }
    }

    @override
    void initState() {
    _verifyUserLoggedIn();
    super.initState();
    _controllerVideo = VideoPlayerController.asset(
        //'https://firebasestorage.googleapis.com/v0/b/data-7-1b8b7.appspot.com/o/ACADEMIA-SEVEN-CARE_2.mp4?alt=media&token=3239ba64-4b69-453b-bcab-649f5d0b69fd')
        'images/bg-video.mp4',
        )
      ..initialize().then((_) {
        _controllerVideo.play();
        _controllerVideo.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controllerVideo.dispose();

    super.dispose();
  }

  Widget _signInWithText(){
      return Column(
        children: <Widget>[
          Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Você também pode se cadastrar com:',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ],
      );
    }

    Widget _socialButton(Function onTap, AssetImage logo) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
              image: logo,
            ),
          ),
        ),
      );
    }
    Widget _socialButtonRow() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _socialButton(
              () => print('Login with Facebook'),
              AssetImage(
                'images/facebook.png',
              ),
            ),
            _socialButton(
              () => print('Login with Google'),
              AssetImage(
                'images/google.png',
              ),
            ),
          ],
        ),
      );
    }

    Widget _signUpButton()
    {
      return GestureDetector(
        onTap: (){
            Navigator.pushNamed(context, "/signup");
          },
        child:  RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Não possui conta?\t",
                  style: TextStyle(color: Colors.white,
                  fontSize: 15.0
   
                  ) 
                ),
                TextSpan(
                  text: "Cadastre-se!",
                  style: TextStyle(color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold                  
                  )
                )
              ],
            ),
          ),
      );
    }
  Widget _forgotPassword()
  {
     return Container(
      alignment: Alignment.centerRight,
        child: FlatButton(
          padding: EdgeInsets.only(right: 0),
          child: Text(
            "Esqueceu a senha?",                               
          style: TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (){
          Navigator.pushNamed(context, "/forgot");
        },
        )
    );
                  
  }
  // Widget _rememberMeCheckbox() {
  //   return Container(
  //     alignment: Alignment.centerRight,
  //     height: 20.0,
  //     child: Row(
  //       children: <Widget>[
  //         Theme(
  //           data: ThemeData(unselectedWidgetColor: Colors.white),
  //           child: CircularCheckBox(
  //             value: _rememberMe,
  //             activeColor: Color(0xff38c4d8),
  //             onChanged: (bool value) {
  //               setState(() {
  //                 _rememberMe = value;
  //                 if(_rememberMe == true){
  //                   _verifyUserLoggedIn();
  //                 }
  //               });
  //             },
  //           ),
  //         ),
  //         Text(
  //           'Lembre-se de mim',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 13,
  //             fontWeight: FontWeight.bold,
  //                       ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _loginButton(){
    return Container(
      width: double.infinity,
        child: RaisedButton(
          child: Text(
              "ENTRAR",
            style: TextStyle(
            color: Colors.white, 
            fontSize: SizeConfig.blockSizeHorizontal*4,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold
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
    );
  }
  Widget _emailField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child:Text("E-mail",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 10,),
        TextField(
          controller: _controllerEmail,
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
              hintText: "Insira seu e-mail aqui",
              filled: true,
              fillColor: Colors.white,
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              suffixIcon: Icon(
                Icons.alternate_email,
                color: Color(0xff38c4d8),
              )
          ),
        ),
          
      ],
    );          
  }

  Widget _passwordField(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child:Text("Senha",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: _controllerSenha,
          obscureText: _obscureText,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal*3.3),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(25, 16, 32, 16),
              hintText: "Insira sua senha aqui",                            
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              suffixIcon: IconButton(
                    icon : Icon(_obscureText ? LineAwesomeIcons.eye : LineAwesomeIcons.eye_slash),
                    onPressed: _passwordText,
                    color: Color(0xff38c4d8),
              ),
          ),
        ),
      ],
    );   
    
    
    
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
         child: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: VideoPlayer(_controllerVideo),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff212121).withOpacity(0.6)
                ),
                alignment: Alignment.topCenter,
              ),
              Container(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 120
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/logo-s7.png'),
                      SizedBox(height: 30,),
                      
                      _emailField(),
                      SizedBox(height: 30,),
               
                      _passwordField(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                           //_rememberMeCheckbox(),
                           _forgotPassword(),
                        ],
                       ),
                       SizedBox(height: 10,),
                      _loginButton(),
                      SizedBox(height: 10,),
                      _signUpButton(),
                      SizedBox(height: 8,),
                      _signInWithText(),
                      _socialButtonRow(),
                    ],
                  ),
                ),
              )
            ],
          ),
          
        ),
      ),
    );
    
    }
}