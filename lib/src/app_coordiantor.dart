import 'package:flutter/material.dart';

import 'domain/entities/conversation.dart';
import 'presentations/chat_detail/chat_detail_screen.dart';
import 'presentations/shared/dialogs/delete_conversation_dialog.dart';

extension AppCoordiantor on BuildContext {
  Future<void> startDetailChat(String? conversationId) {
    return Navigator.pushNamed(
      this,
      ChatDetailScreen.routeName,
      arguments: conversationId,
    );
  }

  Future<bool?> startDeleteDialog(Conversation conversation) {
    return showDialog(
      context: this,
      builder: (ctx) => DeleteConversationDialog(conversation.title),
    );
  }
}
