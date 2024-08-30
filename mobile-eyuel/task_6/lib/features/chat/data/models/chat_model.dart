import '../../../auth/data/model/user_model.dart';
import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel(super.id, super.user1, super.user2);

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      json['_id'],
      UserModel.fromJson(json['user1']),
      UserModel.fromJson(json['user2']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user1': (user1 as UserModel).toJson(),
      'user2': (user2 as UserModel).toJson(),
    };
  }
}
