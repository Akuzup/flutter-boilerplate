import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'application.dart';
import 'core/configurations/configurations.dart';
import 'dependency/di.dart';
import 'presentations/chat_list/bloc/chat_list_bloc.dart';
import 'presentations/dashboard/bloc/dashboard_bloc.dart';

class AppDelegate {
  static void run(Map<String, dynamic> env) {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      Configurations.setConfiguration(env);

      await configureDependencies(environment: Environment.prod);

      runApp(
        Application(
          providers: [
            BlocProvider<DashboardBloc>(
              create: (context) => injector.get<DashboardBloc>(),
            ),
            BlocProvider<ChatListBloc>(
              create: (context) => injector.get<ChatListBloc>(),
            ),
          ],
        ),
      );
    }, (error, stackTrace) => log(error.toString()));
  }
}
