import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../settings/settings_screen.dart';
import 'state_ui/dashboard_state_ui.dart';

extension DasboardTabExtension on DashboardTab {
  String get name {
    switch (this) {
      case DashboardTab.home:
        return 'Home';
      case DashboardTab.settings:
        return 'Settings';
    }
  }

  Widget get icon {
    switch (this) {
      case DashboardTab.home:
        return const Icon(Icons.home);
      case DashboardTab.settings:
        return const Icon(Icons.settings);
    }
  }

  Widget builder(BuildContext context) {
    switch (this) {
      case DashboardTab.home:
        return const HomeScreen();
      case DashboardTab.settings:
        return const SettingsScreen();
    }
  }
}
