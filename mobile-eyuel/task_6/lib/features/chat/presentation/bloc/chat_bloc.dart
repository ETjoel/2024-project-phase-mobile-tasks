import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/delete_chat.dart';
import '../../domain/usecases/get_chat_message_usecase.dart';
import '../../domain/usecases/initiate_chat_usecase.dart';
import '../../domain/usecases/view_my_chats_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ViewMyChatsUseCase viewMyChatsUseCase;
  final InitiateChatUseCase initiateChatUseCase;
  final GetChatMessageUseCase getChatMessageUseCase;
  final DeleteChatUseCase deleteChatUseCase;
  ChatBloc(
      {required this.viewMyChatsUseCase,
      required this.initiateChatUseCase,
      required this.getChatMessageUseCase,
      required this.deleteChatUseCase})
      : super(ChatListInitial()) {
    on<LoadMyChatListEvent>((event, emit) async {
      emit(ChatListLoading());

      final result = await viewMyChatsUseCase.call();

      result.fold(
        (failure) => emit(ChatError(message: failure.message)),
        (chatList) => emit(ChatListLoaded(chatList: chatList)),
      );
    });

    on<InitiateChatEvent>((event, emit) async {
      emit(InitiateChatLoading());

      final result = await initiateChatUseCase.call(event.reciverId);

      result.fold(
        (failure) => emit(ChatError(message: failure.message)),
        (chat) => emit(InitiateChatSuccess(chat)),
      );
    });

    on<GetChatMessagesEvent>((event, emit) async {
      emit(ChatRoomMessageLoading());

      final result = await getChatMessageUseCase.call(event.userId);

      result.fold(
        (failure) => emit(ChatError(message: failure.message)),
        (messageEntity) => emit(ChatRoomMessageSuccess(messageEntity)),
      );
    });

    on<DeleteChatEvent>((event, emit) async {
      emit(DeleteChatLoading());

      final result = await deleteChatUseCase.call(event.chatId);

      result.fold(
        (failure) => emit(ChatError(message: failure.message)),
        (unit) => emit(DeleteChatSuccess()),
      );
    });
  }
}
