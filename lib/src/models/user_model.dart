
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.message = "",
    this.email = "",
    this.token = "",
    this.refreshToken = "",
  });

  String message;
  String email;
  String token;
  String refreshToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
    message: json["message"],
    email: json["email"],
    token: json["token"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "email": email,
    "token": token,
    "refreshToken": refreshToken,
  };
}
