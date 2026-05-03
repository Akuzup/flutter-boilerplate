import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/configurations/configurations.dart';
import '../../core/providers/chat_network_provider.dart';

@module
abstract class DatesourceModule {
  @lazySingleton
  ChatNetworkProvider createChatNetworkProvider(
    SharedPreferences sharedPreferences,
  ) {
    final config = Configurations.chatConfiguration;
    return ChatNetworkProvider(
      config.baseUrl,
      config.apiKey,
      sharedPreferences,
      timeout: config.timeout,
    );
  }
}
