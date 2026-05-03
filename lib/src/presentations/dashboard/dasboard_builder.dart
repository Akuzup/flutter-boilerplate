import 'package:flutter/material.dart';

import '../chat_list/chat_list_screen.dart';
import '../settings/settings_screen.dart';
import 'state_ui/dashboard_state_ui.dart';

extension DasboardTabExtension on DashboardTab {
  String get name {
    switch (this) {
      case DashboardTab.chat:
        return 'Chat';
      case DashboardTab.settings:
        return 'Settings';
    }
  }

  Widget get icon {
    switch (this) {
      case DashboardTab.chat:
        return const Icon(Icons.chat);
      case DashboardTab.settings:
        return const Icon(Icons.settings);
    }
  }

  Widget builder(BuildContext context) {
    switch (this) {
      case DashboardTab.chat:
        return const ChatListScreen();
      case DashboardTab.settings:
        return const SettingsScreen();
    }
  }
}
