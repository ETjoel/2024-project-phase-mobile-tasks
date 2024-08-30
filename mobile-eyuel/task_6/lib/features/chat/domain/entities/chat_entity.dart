import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user.dart';

class ChatEntity extends Equatable {
  final String id;
  final UserEntity user1;
  final UserEntity user2;

  const ChatEntity(this.id, this.user1, this.user2);

  @override
  List<Object?> get props => [id, user1, user2];
}
