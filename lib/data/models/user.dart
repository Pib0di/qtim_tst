import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String phone;
  final String data;
  final List<String> avatarUrls;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.data,
    required this.avatarUrls,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    String? phone,
    String? data,
    List<String>? avatarUrls,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      data: data ?? this.data,
      avatarUrls: avatarUrls ?? this.avatarUrls,
    );
  }
}
