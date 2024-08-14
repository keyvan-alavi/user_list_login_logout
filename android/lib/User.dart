class User {
  String? id;
  String? username;
  String? email;
  String? password;
  String? repassword;

  User({this.id, this.username, this.email, this.password, this.repassword});

  Map <String, dynamic> toJson() {
    return {
      'id': id,
      'Username': username,
      'Email': email,
      'Password': password,
      'Re_Password': repassword,
    };
  }
  User.fromJson(Map<String, dynamic> json){
    id=json[('id')];
    username=json [('Username')];
    email=json['Email'];
    password=json['Password'];
    repassword=json['Re_Password'];
  }
}