part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class SelectedTabChangedEvent extends DashboardEvent {
  final DashboardTab tab;

  SelectedTabChangedEvent({
    required this.tab,
  });
}

class SelectedIndexChangedEvent extends DashboardEvent {
  final int index;

  SelectedIndexChangedEvent({
    required this.index,
  });
}
