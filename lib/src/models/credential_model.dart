import 'dart:convert';

Credential credentialFromJson(String str) => Credential.fromJson(json.decode(str));

String credentialToJson(Credential data) => json.encode(data.toJson());

class Credential {
  Credential({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}