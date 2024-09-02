import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/providers/yescaleai_network_provider.dart';

@module
abstract class DatesourceModule {
  @lazySingleton
  YescaleaiNetworkProvider createYescaleaiNetworkProvider(
    String baseUrl,
    String apiKey,
    SharedPreferences sharedPreferences,
  ) =>
      YescaleaiNetworkProvider(baseUrl, apiKey, sharedPreferences);
}
