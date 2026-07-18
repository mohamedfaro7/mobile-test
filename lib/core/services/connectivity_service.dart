import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>> _controller =
      StreamController<List<ConnectivityResult>>.broadcast();
  List<ConnectivityResult> _lastResult = [ConnectivityResult.none];

  Stream<List<ConnectivityResult>> get onConnectivityChanged => _controller.stream;
  List<ConnectivityResult> get currentStatus => _lastResult;
  bool get isConnected => _lastResult.any((r) => r != ConnectivityResult.none);

  Future<void> init() async {
    _lastResult = await _connectivity.checkConnectivity();
    _controller.add(_lastResult);

    _connectivity.onConnectivityChanged.listen((result) {
      _lastResult = result;
      _controller.add(result);
    });
  }

  Future<List<ConnectivityResult>> checkConnectivity() async {
    _lastResult = await _connectivity.checkConnectivity();
    return _lastResult;
  }

  Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.any((r) => r != ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _controller.close();
  }
}
