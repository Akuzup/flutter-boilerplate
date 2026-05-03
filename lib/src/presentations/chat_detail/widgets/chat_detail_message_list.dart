import 'package:flutter/material.dart';

import '../../../core/components/message_bubble.dart';
import '../../../core/components/typing_indicator.dart';
import '../../../domain/entities/message_completion.dart';

class ChatDetailMessageList extends StatelessWidget {
  final List<MessageCompletion> messages;
  final bool isSending;
  final ScrollController scrollController;

  const ChatDetailMessageList({
    super.key,
    required this.messages,
    required this.isSending,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: messages.length + (isSending ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length && isSending) {
          return const TypingIndicator();
        }
        return MessageBubble(message: messages[index]);
      },
    );
  }
}
