import 'package:equatable/equatable.dart';

import 'chat_entity.dart';

class MessageEntity extends Equatable {
  final String id;
  final ChatEntity chat;
  final String content;
  final String type;

  const MessageEntity(this.id, this.chat, this.content, this.type);

  @override
  List<Object?> get props => [id, chat, content, type];
}
