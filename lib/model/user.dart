
class User{
  String _userID;
  String _name;
  String _email;
  String _password;
  String _userType;


  User();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "name": this.name,
      "email" : this.email,
      "userType" : this.userType,
    };

    return map;
  }


  String get userType => _userType;

  set userType(String value) {
    _userType = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

}