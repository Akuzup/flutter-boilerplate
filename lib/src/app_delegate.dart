import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'application.dart';
import 'core/configurations/configurations.dart';
import 'dependency/di.dart';
import 'presenstations/dashboard/bloc/dashboard_bloc.dart';

class AppDelegate {
  static void run(Map<String, dynamic> env) {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        Configurations.setConfiguration(env);

        await configureDependencies(environment: Environment.prod);

        runApp(
          Application(
            providers: [
              BlocProvider<DashboardBloc>(
                create: (context) => injector.get<DashboardBloc>(),
              ),
            ],
          ),
        );
      },
      (error, stackTrace) => log(error.toString()),
    );
  }
}
