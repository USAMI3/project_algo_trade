class FirebaseModel {
  String? uid;
  String? email;
  String? name;
  String? password;
  String? apiKey;
  String? secretKey;

  FirebaseModel(
      {this.uid,
      this.email,
      this.name,
      this.password,
      this.apiKey,
      this.secretKey});

  //receiving data from server
  factory FirebaseModel.fromMap(map) {
    return FirebaseModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
      apiKey: map['apiKey'],
      secretKey: map['secretKey'],
    );
  }
//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password': password,
      'apiKey': apiKey,
      'secretKey': secretKey,
    };
  }
}
