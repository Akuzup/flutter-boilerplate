import 'package:flutter/material.dart';

class DeleteConversationDialog extends StatelessWidget {
  const DeleteConversationDialog(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Conversation'),
      content: Text('Delete "${title.isEmpty ? 'New Chat' : title}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
