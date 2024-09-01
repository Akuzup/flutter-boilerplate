import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/configuration.dart';

@module
abstract class SupabaseModule {
  @singleton
  @preResolve
  Future<Supabase> initSupbase() => Supabase.initialize(
        url: Configuration.supabaseProjectUrl,
        anonKey: Configuration.supabaseApiKey,
      );
}
