// ignore_for_file: one_member_abstracts

import '../entities/message_completion.dart';

abstract class YescaleaiRepository {
  Future<MessageCompletion?> sendCompletions({
    required String aiModel,
    required String newMessage,
    List<MessageCompletion>? messages,
  });
}
