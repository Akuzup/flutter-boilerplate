import 'package:flutter/material.dart';

import 'dashboard/dashboard_screen.dart';
import 'home/home_page.dart';
import 'settings/settings_screen.dart';

class Routes {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardScreen.routeName:
        return _buildRoute(const DashboardScreen());
      case HomeScreen.routeName:
        return _buildRoute(const HomeScreen());
      case SettingsScreen.routeName:
        return _buildRoute(const SettingsScreen());
      default:
        return _buildRoute(const ErrorScreen());
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}
