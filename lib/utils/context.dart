import 'package:flutter/material.dart';

extension Utils on BuildContext {
  ColorScheme getColorScheme() {
    return Theme.of(this).colorScheme;
  }

  TextTheme getTextTheme() {
    return Theme.of(this).textTheme;
  }

  Future<T?> pushPage<T extends Object?>({
    required Widget Function(BuildContext) builder,
    RouteSettings? settings,
    maintainState = true,
    fullscreenDialog = false,
    allowSnapshotting = true,
  }) {
    return Navigator.of(this).push(
      MaterialPageRoute<T>(
        builder: builder,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        allowSnapshotting: allowSnapshotting,
      ),
    );
  }

  void popPage<T extends Object?>([T? result]) {
    return Navigator.of(this).pop<T>(result);
  }
}
