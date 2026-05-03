import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dependency/di.dart';
import 'chat_detail/bloc/chat_detail_bloc.dart';
import 'chat_detail/chat_detail_screen.dart';
import 'chat_list/chat_list_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'settings/settings_screen.dart';

class Routes {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case ChatListScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case ChatDetailScreen.routeName:
        final conversationId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ChatDetailBloc(
              injector.get(),
              conversationId: conversationId,
            ),
            child: const ChatDetailScreen(),
          ),
        );
      case SettingsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
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
