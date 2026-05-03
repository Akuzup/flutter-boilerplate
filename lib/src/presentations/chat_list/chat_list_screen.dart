import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_coordiantor.dart';
import '../../core/components/conversation_tile.dart';
import '../../domain/entities/conversation.dart';
import 'bloc/chat_list_bloc.dart';
import 'widgets/chat_list_empty.dart';

class ChatListScreen extends StatefulWidget {
  static const String routeName = '/chat-list';

  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  Future<void> _openDetail(BuildContext context, String? conversationId) async {
    await context.startDetailChat(conversationId);

    if (context.mounted) {
      context.read<ChatListBloc>().add(const LoadConversationsEvent());
    }
  }

  Future<void> _showDeleteDialog(Conversation conversation) async {
    final shouldDelete = await context.startDeleteDialog(conversation);
    if (shouldDelete == true) {
      context.read<ChatListBloc>().add(
        DeleteConversationEvent(conversationId: conversation.id),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ChatListBloc>().add(const LoadConversationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chat'), centerTitle: true),
      body: BlocConsumer<ChatListBloc, ChatListState>(
        listenWhen: (prev, curr) => curr is ConversationDeleted,
        listener: (context, state) {
          if (state is ConversationDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Conversation deleted')),
            );
          }
        },
        buildWhen: (prev, curr) =>
            curr is ChatListLoading ||
            curr is ChatListLoaded ||
            curr is ConversationDeleted ||
            curr is ChatListInitial,
        builder: (context, state) {
          if (state is ChatListLoading && state.ui.conversations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final conversations = state.ui.conversations;

          if (conversations.isEmpty) {
            return const ChatListEmpty();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return ConversationTile(
                conversation: conversation,
                onTap: () => _openDetail(context, conversation.id),
                onDelete: () => _showDeleteDialog(conversation),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openDetail(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
