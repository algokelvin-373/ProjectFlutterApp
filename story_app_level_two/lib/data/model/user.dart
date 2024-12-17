import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? email;
  String? password;

  User({this.email, this.password});

  @override
  String toString() => 'User(email: $email, password: $password)';

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }

  factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.email == email && other.password == password;
  }

  @override
  int get hashCode => Object.hash(email, password);
}
