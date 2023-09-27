import 'dart:convert';

class User {
  final String fullname;
  final String username;
  final String email;
  final String password;
  final String token;
  final String id;
  User({
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'username': username,
      'email': email,
      'password': password,
      'token': token,
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullname: map['fullname'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
