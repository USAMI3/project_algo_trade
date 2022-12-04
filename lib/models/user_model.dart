class UserModel {
  int? id;
  String? name;
  String? imageUrl;
  String? email;
  String? password;
  String? uid;

  UserModel({
    this.id,
    this.name,
    this.imageUrl,
    this.email,
     this.password,
     this.uid,
  });
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
      name: map['name'],

    );
  }
//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid' : uid,
      'email' : email,
      'password' : password,
      'name' : name,
    };
  }

}