import 'dart:async';
import 'package:flutter/widgets.dart';

class NavigationHistoryObserver extends NavigatorObserver {
  final List<Route<dynamic>?> _history = <Route<dynamic>?>[];

  List<Route<dynamic>> get history => List<Route<dynamic>>.from(_history);

  Route<dynamic>? get top => _history.last;

  final List<Route<dynamic>?> _poppedRoutes = <Route<dynamic>?>[];

  List<Route<dynamic>> get poppedRoutes =>
      List<Route<dynamic>>.from(_poppedRoutes);

  Route<dynamic>? get next => _poppedRoutes.last;

  // A Stream
  final StreamController _historyChangeStreamController =
      StreamController.broadcast();

// Accessor

  Stream<dynamic> get historyStreamChange =>
      _historyChangeStreamController.stream;
}
