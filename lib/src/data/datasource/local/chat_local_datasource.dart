import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/conversation.dart';

const String _conversationsKey = 'chat_conversations';

@singleton
class ChatLocalDatasource {
  final SharedPreferences _prefs;

  ChatLocalDatasource(this._prefs);

  Future<List<Conversation>> getConversations() async {
    final jsonStr = _prefs.getString(_conversationsKey);
    if (jsonStr == null || jsonStr.isEmpty) return [];
    final List<dynamic> jsonList = jsonDecode(jsonStr);
    return jsonList
        .map((e) => Conversation.fromJson(Map<String, dynamic>.from(e)))
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<void> saveConversation(Conversation conversation) async {
    final conversations = await getConversations();
    final index = conversations.indexWhere((c) => c.id == conversation.id);
    if (index >= 0) {
      conversations[index] = conversation;
    } else {
      conversations.insert(0, conversation);
    }
    await _saveAll(conversations);
  }

  Future<void> deleteConversation(String id) async {
    final conversations = await getConversations();
    conversations.removeWhere((c) => c.id == id);
    await _saveAll(conversations);
  }

  Future<void> _saveAll(List<Conversation> conversations) async {
    final jsonStr = jsonEncode(conversations.map((c) => c.toJson()).toList());
    await _prefs.setString(_conversationsKey, jsonStr);
  }
}
