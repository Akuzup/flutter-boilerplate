import 'configurations.dart';

class DefaultConfigurations {
  static const String supabaseProjectUrl = 'https://api.yescaleai.com/v1/';
  static const String supabaseApiKey = 'sk-proj-1234567890';
  static YescaleaiConfiguration yescaleaiConfiguration = YescaleaiConfiguration(
    baseUrl: 'https://api.yescaleai.com/v1/',
    apiKey: 'sk-proj-1234567890',
    enable: false,
  );
}
