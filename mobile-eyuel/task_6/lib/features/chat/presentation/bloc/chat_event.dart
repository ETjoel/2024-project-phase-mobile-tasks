part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class InitiateChatEvent extends ChatEvent {
  final String reciverId;

  InitiateChatEvent({required this.reciverId});
}

final class LoadMyChatListEvent extends ChatEvent {}

final class GetChatMessagesEvent extends ChatEvent {
  final String chatId;
  GetChatMessagesEvent({required this.chatId});
}

final class DeleteChatEvent extends ChatEvent {
  final String chatId;
  DeleteChatEvent({required this.chatId});
}
