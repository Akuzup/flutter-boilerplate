import 'package:injectable/injectable.dart';

import '../entities/message_completion.dart';
import '../repository/yescalseai_repository.dart';

@injectable
class YescaleaiUsecase {
  final YescaleaiRepository repository;

  YescaleaiUsecase({required this.repository});

  Future<MessageCompletion?> sendCompletions({
    required String aiModel,
    required String newMessage,
    List<MessageCompletion>? messages,
  }) async {
    return repository.sendCompletions(
      aiModel: aiModel,
      newMessage: newMessage,
      messages: messages,
    );
  }
}
