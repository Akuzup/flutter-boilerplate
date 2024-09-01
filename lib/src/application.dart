import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presenstations/dashboard/dashboard_screen.dart';
import 'presenstations/routes.dart';

class Application extends StatefulWidget {
  const Application({
    super.key,
    required this.providers,
  });

  final List<BlocProvider> providers;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: widget.providers,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: DashboardScreen.routeName,
      ),
    );
  }
}
