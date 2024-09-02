import 'package:injectable/injectable.dart';

import '../../domain/entities/message_completion.dart';
import '../../domain/repository/yescalseai_repository.dart';
import '../datasource/remote/yescaleai_api.dart';

@Injectable(as: YescaleaiRepository)
class YescaleaiRepositoryImpl extends YescaleaiRepository {
  final YescaleaiApi api;

  YescaleaiRepositoryImpl({required this.api});

  @override
  Future<MessageCompletion?> sendCompletions(
      {required String aiModel,
      required String newMessage,
      List<MessageCompletion>? messages}) async {
    final data = await api.sendCompletions(
      payload: {
        'model': aiModel,
        'messages': [
          ...?messages?.map((e) => e.toJson()),
          {
            'role': 'user',
            'content': newMessage,
          },
        ]
      },
    );

    final choices = data.data['choices'];
    if (choices is List && choices.isNotEmpty) {
      final message = Map<String, dynamic>.from(choices.first['message']);
      return MessageCompletion.fromJson(message);
    }
    return null;
  }
}
