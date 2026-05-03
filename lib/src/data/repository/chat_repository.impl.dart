import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/configurations/configurations.dart';
import '../../core/networking/exception/api_exception.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message_completion.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasource/local/chat_local_datasource.dart';
import '../datasource/remote/chat_api.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatApi api;
  final ChatLocalDatasource localDatasource;

  ChatRepositoryImpl({required this.api, required this.localDatasource});

  @override
  Future<MessageCompletion?> sendCompletions({
    required String newMessage,
    List<MessageCompletion>? messages,
  }) async {
    try {
      final config = Configurations.chatConfiguration;

      final contents = [
        if (messages != null)
          ...messages.map((m) => {
                'parts': [
                  {'text': m.content}
                ],
                'role': m.role == 'assistant' ? 'model' : 'user',
              }),
        {
          'parts': [
            {'text': newMessage}
          ],
          'role': 'user',
        },
      ];

      final payload = {
        'contents': contents,
        'generationConfig': {
          'temperature': 1,
          'maxOutputTokens': config.maxTokens,
        },
      };

      final response = await api.sendCompletions(
        model: config.model,
        apiKey: config.apiKey,
        payload: payload,
      );

      final data = response.data as Map<String, dynamic>;
      final candidates = data['candidates'];
      if (candidates is List && candidates.isNotEmpty) {
        final content = candidates.first['content'];
        final parts = content['parts'];
        if (parts is List && parts.isNotEmpty) {
          final text = parts.first['text'] as String;
          return MessageCompletion(text, 'assistant');
        }
      }
      return null;
    } on ApiException catch (e) {
      throw ApiException(
        message: 'AI service error: ${e.message}',
        code: e.code,
        errors: e.errors,
      );
    } on DioException catch (e) {
      throw ApiException(
        message:
            'Network error: ${e.message ?? 'Cannot connect to AI service'}',
        code: e.response?.statusCode?.toString(),
      );
    }
  }

  @override
  Future<List<Conversation>> getConversations() =>
      localDatasource.getConversations();

  @override
  Future<Conversation?> getConversation(String id) async {
    final conversations = await localDatasource.getConversations();
    final index = conversations.indexWhere((c) => c.id == id);
    return index >= 0 ? conversations[index] : null;
  }

  @override
  Future<void> saveConversation(Conversation conversation) =>
      localDatasource.saveConversation(conversation);

  @override
  Future<void> deleteConversation(String id) =>
      localDatasource.deleteConversation(id);
}
