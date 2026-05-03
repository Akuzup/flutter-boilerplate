import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat_detail_bloc.dart';
import 'widgets/chat_detail_empty.dart';
import 'widgets/chat_detail_input_bar.dart';
import 'widgets/chat_detail_message_list.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = '/chat-detail';

  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    context.read<ChatDetailBloc>().add(SendMessageEvent(message: message));
    _messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatDetailBloc, ChatDetailState>(
      listenWhen: (prev, curr) =>
          curr is MessageSent || curr is ChatDetailError,
      listener: (context, state) {
        if (state is MessageSent) {
          _scrollToBottom();
        }
        if (state is ChatDetailError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      buildWhen: (prev, curr) => curr is! ChatDetailError,
      builder: (context, state) {
        final conversation = state.ui.conversation;
        final isSending = state is MessageSending;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              conversation?.title.isEmpty ?? true
                  ? 'New Chat'
                  : conversation!.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: conversation == null || conversation.messages.isEmpty
                    ? const ChatDetailEmpty()
                    : ChatDetailMessageList(
                        messages: conversation.messages,
                        isSending: isSending,
                        scrollController: _scrollController,
                      ),
              ),
              ChatDetailInputBar(
                messageController: _messageController,
                isSending: isSending,
                onSend: _sendMessage,
              ),
            ],
          ),
        );
      },
    );
  }
}
