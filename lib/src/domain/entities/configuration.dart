class Configuration {
  static String _supabaseProjectUrl = '';
  static String _supabaseApiKey = '';

  static String get supabaseProjectUrl => _supabaseProjectUrl;
  static String get supabaseApiKey => _supabaseApiKey;

  Configuration.setConfiguration(Map<String, dynamic> json) {
    _supabaseProjectUrl = json['supabase_project_url'];
    _supabaseApiKey = json['supabase_api_key'];
  }

  Map<String, dynamic> toJson() => {
        'supabase_project_url': supabaseProjectUrl,
        'supabase_api_key': supabaseApiKey,
      };
}
