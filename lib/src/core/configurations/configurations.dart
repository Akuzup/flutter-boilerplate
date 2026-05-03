import 'default_config.dart';

class Configurations {
  static ChatConfiguration _chatConfiguration =
      DefaultConfigurations.chatConfiguration;

  static ChatConfiguration get chatConfiguration => _chatConfiguration;

  Configurations.setConfiguration(Map<String, dynamic> json) {
    _chatConfiguration =
        json['chat'] != null && json['chat'] is Map
            ? ChatConfiguration.fromJson(json['chat'])
            : DefaultConfigurations.chatConfiguration;
  }

  Map<String, dynamic> toJson() => {
        'chat': chatConfiguration.toJson(),
      };
}

class ChatConfiguration {
  final String baseUrl;
  final String apiKey;
  final String model;
  final bool enable;
  final bool stream;
  final bool enableThinking;
  final int maxTokens;
  final int timeout;

  ChatConfiguration({
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    required this.enable,
    this.stream = false,
    this.enableThinking = false,
    this.maxTokens = 16384,
    this.timeout = 60,
  });

  Map<String, dynamic> toJson() {
    return {
      'baseUrl': baseUrl,
      'apiKey': apiKey,
      'model': model,
      'enable': enable,
      'stream': stream,
      'enableThinking': enableThinking,
      'maxTokens': maxTokens,
      'timeout': timeout,
    };
  }

  factory ChatConfiguration.fromJson(Map<String, dynamic> map) {
    return ChatConfiguration(
      baseUrl: map['baseUrl'] ?? '',
      apiKey: map['apiKey'] ?? '',
      model: map['model'] ?? 'gemini-2.5-flash-lite',
      enable: map['enable'] ?? false,
      stream: map['stream'] ?? false,
      enableThinking: map['enableThinking'] ?? false,
      maxTokens: map['maxTokens'] ?? 16384,
      timeout: map['timeout'] ?? 60,
    );
  }
}
