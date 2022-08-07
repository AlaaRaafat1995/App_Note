import 'dart:convert';

class Model {
  String? email;
  String? password;
  String? name;
  Model({this.email, this.password, this.name});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  Model copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return Model(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }
}
