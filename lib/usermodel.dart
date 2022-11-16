class UserModel {
  String? email;
  String? password;
  String? uid;

  UserModel({this.email, this.password, this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['uid'] = this.uid;
    return data;
  }
}