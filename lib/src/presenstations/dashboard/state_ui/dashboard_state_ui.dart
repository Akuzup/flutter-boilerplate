enum DashboardTab {
  home,
  settings,
}

class DashboardStateUi {
  final List<DashboardTab> tabs;
  final DashboardTab selectedTab;

  DashboardStateUi({
    required this.tabs,
    required this.selectedTab,
  });

  DashboardStateUi copyWith({
    List<DashboardTab>? tabs,
    DashboardTab? selectedTab,
  }) {
    return DashboardStateUi(
      tabs: tabs ?? this.tabs,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
