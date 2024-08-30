import '../../domain/entities/message_entity.dart';
import 'chat_model.dart';

class MessageModel extends MessageEntity {
  const MessageModel(super.id, super.chat, super.content, super.type);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(json['_id'], ChatModel.fromJson(json['chat']),
        json['content'], json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chat': (chat as ChatModel).toJson(),
      'content': content,
      'type': type,
    };
  }
}
