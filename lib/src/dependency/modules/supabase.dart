import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/configurations/configurations.dart';

@module
abstract class SupabaseModule {
  @singleton
  @preResolve
  Future<Supabase> initSupbase() => Supabase.initialize(
        url: Configurations.supabaseProjectUrl,
        anonKey: Configurations.supabaseApiKey,
      );
}
