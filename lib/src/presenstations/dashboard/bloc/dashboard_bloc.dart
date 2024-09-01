import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../state_ui/dashboard_state_ui.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

@singleton
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc()
      : super(
          DashboardInitial(
            ui: DashboardStateUi(
                tabs: [DashboardTab.home, DashboardTab.settings],
                selectedTab: DashboardTab.home),
          ),
        ) {
    on<SelectedTabChangedEvent>(_onMapSelectedTabChangedEvent);
    on<SelectedIndexChangedEvent>(_onMapSelectedIndexChangedEvent);
  }

  FutureOr<void> _onMapSelectedTabChangedEvent(
      SelectedTabChangedEvent event, Emitter<DashboardState> emit) async {
    emit(SelectedTabChangedState(
      ui: state.ui.copyWith(selectedTab: event.tab),
    ));
  }

  FutureOr<void> _onMapSelectedIndexChangedEvent(
      SelectedIndexChangedEvent event, Emitter<DashboardState> emit) async {
    if (event.index >= 0 && event.index < state.ui.tabs.length) {
      final tab = state.ui.tabs[event.index];

      emit(SelectedIndexChangedState(
        ui: state.ui.copyWith(selectedTab: tab),
      ));
    } else {
      emit(SelectedTabFailedState(
        'Index out of bounds',
        Exception('Index out of bounds'),
        ui: state.ui,
      ));
    }
  }
}
