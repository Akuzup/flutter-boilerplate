part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {
  final DashboardStateUi ui;

  const DashboardState({
    required this.ui,
  });
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial({required super.ui});
}

final class SelectedTabChangedState extends DashboardState {
  const SelectedTabChangedState({required super.ui});
}

final class SelectedIndexChangedState extends DashboardState {
  const SelectedIndexChangedState({required super.ui});
}

final class SelectedTabFailedState extends DashboardState {
  const SelectedTabFailedState(this.message, this.exception,
      {required super.ui});

  final String message;
  final dynamic exception;
}
