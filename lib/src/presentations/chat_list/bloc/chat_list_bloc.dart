import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/networking/exception/api_exception.dart';
import '../../../domain/usecase/chat_usecase.dart';
import '../state_ui/chat_list_state_ui.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

@singleton
class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatUsecase _chatUsecase;

  ChatListBloc(this._chatUsecase)
      : super(const ChatListInitial(ui: ChatListStateUi())) {
    on<LoadConversationsEvent>(_onLoadConversations);
    on<CreateNewChatEvent>(_onCreateNewChat);
    on<DeleteConversationEvent>(_onDeleteConversation);
  }

  FutureOr<void> _onLoadConversations(
    LoadConversationsEvent event,
    Emitter<ChatListState> emit,
  ) async {
    emit(ChatListLoading(ui: state.ui));
    try {
      final conversations = await _chatUsecase.getConversations();
      emit(ChatListLoaded(
        ui: state.ui.copyWith(conversations: conversations),
      ));
    } on ApiException catch (e) {
      emit(ChatListError(
        message: 'Failed to load conversations: ${e.message}',
        exception: e,
        ui: state.ui,
      ));
    } catch (e) {
      emit(ChatListError(
        message: 'An unexpected error occurred',
        exception: e,
        ui: state.ui,
      ));
    }
  }

  FutureOr<void> _onCreateNewChat(
    CreateNewChatEvent event,
    Emitter<ChatListState> emit,
  ) {
    // Navigation is handled by the screen — no state change needed
  }

  FutureOr<void> _onDeleteConversation(
    DeleteConversationEvent event,
    Emitter<ChatListState> emit,
  ) async {
    try {
      await _chatUsecase.deleteConversation(event.conversationId);
      final conversations = await _chatUsecase.getConversations();

      emit(ConversationDeleted(
        ui: state.ui.copyWith(conversations: conversations),
      ));
    } catch (e) {
      emit(ChatListError(
        message: 'Failed to delete conversation',
        exception: e,
        ui: state.ui,
      ));
    }
  }
}
