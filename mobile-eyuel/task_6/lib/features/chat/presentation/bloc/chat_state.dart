part of 'chat_bloc.dart';

@immutable
sealed class ChatState extends Equatable {}

final class ChatListInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatListLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatListLoaded extends ChatState {
  final List<ChatEntity> chatList;
  ChatListLoaded({required this.chatList});
  @override
  List<Object?> get props => [chatList];
}

final class ChatRoomInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatRoomMessageLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatRoomMessageSuccess extends ChatState {
  final List<MessageEntity> messageEntity;

  ChatRoomMessageSuccess(this.messageEntity);

  @override
  List<Object?> get props => [messageEntity];
}

final class InitiateChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

final class InitiateChatSuccess extends ChatState {
  final ChatEntity chatEntity;

  InitiateChatSuccess(this.chatEntity);
  @override
  List<Object?> get props => [chatEntity];
}

final class DeleteChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

final class DeleteChatSuccess extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatError extends ChatState {
  final String message;
  ChatError({required this.message});
  @override
  List<Object?> get props => [message];
}
