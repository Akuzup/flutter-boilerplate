import 'default_config.dart';

class Configurations {
  static String _supabaseProjectUrl = DefaultConfigurations.supabaseProjectUrl;
  static String _supabaseApiKey = DefaultConfigurations.supabaseApiKey;
  static YescaleaiConfiguration _yescaleaiConfiguration =
      DefaultConfigurations.yescaleaiConfiguration;

  static String get supabaseProjectUrl => _supabaseProjectUrl;
  static String get supabaseApiKey => _supabaseApiKey;
  static YescaleaiConfiguration get yescaleaiConfiguration =>
      _yescaleaiConfiguration;

  Configurations.setConfiguration(Map<String, dynamic> json) {
    _supabaseProjectUrl = json['supabase_project_url'];
    _supabaseApiKey = json['supabase_api_key'];
    _yescaleaiConfiguration =
        json['yescaleai'] != null && json['yescaleai'] is Map
            ? YescaleaiConfiguration.fromJson(json['yescaleai'])
            : DefaultConfigurations.yescaleaiConfiguration;
  }

  Map<String, dynamic> toJson() => {
        'supabase_project_url': supabaseProjectUrl,
        'supabase_api_key': supabaseApiKey,
        'yescaleai_configuration': yescaleaiConfiguration.toJson(),
      };
}

class YescaleaiConfiguration {
  final String baseUrl;
  final String apiKey;
  final bool enable;

  YescaleaiConfiguration({
    required this.baseUrl,
    required this.apiKey,
    required this.enable,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'baseUrl': baseUrl});
    result.addAll({'apiKey': apiKey});
    result.addAll({'enable': enable});
    return result;
  }

  factory YescaleaiConfiguration.fromJson(Map<String, dynamic> map) {
    return YescaleaiConfiguration(
      baseUrl: map['baseUrl'] ?? '',
      apiKey: map['apiKey'] ?? '',
      enable: map['enable'] ?? false,
    );
  }
}
