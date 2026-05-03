import 'configurations.dart';

class DefaultConfigurations {
  static ChatConfiguration chatConfiguration = ChatConfiguration(
    baseUrl: 'https://generativelanguage.googleapis.com/v1beta',
    apiKey: '',
    model: 'gemini-2.5-flash-lite',
    enable: false,
    stream: false,
    enableThinking: false,
    maxTokens: 16384,
    timeout: 60,
  );
}
