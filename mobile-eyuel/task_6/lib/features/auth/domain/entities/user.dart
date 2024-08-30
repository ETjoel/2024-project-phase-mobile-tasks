import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserEntity(this.id, this.email, this.name);

  @override
  List<Object?> get props => [id, email, name];
}
