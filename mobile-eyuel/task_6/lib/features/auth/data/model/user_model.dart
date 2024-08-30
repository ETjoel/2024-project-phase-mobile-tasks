import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel(super.id, super.email, super.name);

  factory UserModel.fromJson(json) {
    return UserModel(json['_id'], json['email'], json['name']);
  }

  Map<String, String> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
    };
  }
}
