import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard_bloc.dart';
import 'dasboard_builder.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = 'dashboard';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardBloc get _bloc => context.read<DashboardBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final ui = state.ui;
        return Scaffold(
          body: IndexedStack(
            index: ui.selectedTab.index,
            children: ui.tabs.map((tab) => tab.builder(context)).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ui.selectedTab.index,
            items: ui.tabs
                .map(
                  (tab) => BottomNavigationBarItem(
                    icon: tab.icon,
                    label: tab.name,
                  ),
                )
                .toList(),
            onTap: (index) =>
                _bloc.add(SelectedIndexChangedEvent(index: index)),
          ),
        );
      },
    );
  }
}
