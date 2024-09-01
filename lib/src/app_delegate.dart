import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/src/application.dart';

import 'dependency/di.dart';
import 'domain/entities/configuration.dart';
import 'presenstations/dashboard/bloc/dashboard_bloc.dart';

class AppDelegate {
  static Future<void> run(Map<String, dynamic> env) async {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        Configuration.setConfiguration(env);

        await configureDependencies();
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
