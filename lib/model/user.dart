
class User{
  String _userID;
  String _name;
  String _email;
  String _password;
  String _gender;
  String _userType;
  int _checkin;


  User();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "name": this.name,
      "email" : this.email,
      "gender" : this.gender,
      "userType" : this._userType,
      "check-ins" : this._checkin
    };

    return map;
  }

  int get checkIn => _checkin;

  set checkIn(int value) {
    _checkin = value;
  }

  String get userType => _userType;

  set userType(String value) {
    _userType = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
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