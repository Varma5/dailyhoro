import 'package:flutter/material.dart';
import '../utilities/logger.dart';

class BaseController extends ChangeNotifier with WidgetsBindingObserver {
  /// Constructor for BaseController
  BaseController() {
    // Common initialization code
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    Logger.doLog("BaseController : dispose");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  Future<T?> pushNamedNavigation<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  Future<T?> pushNamedRemoveNavigation<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedReplaceNavigation<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  @override
  void didChangeAccessibilityFeatures() {
    Logger.doLog("BaseController : didChangeAccessibilityFeatures");
  }

  @override
  void didChangePlatformBrightness() {
    Logger.doLog("BaseController : didChangePlatformBrightness");
  }

  @override
  void didHaveMemoryPressure() {
    Logger.doLog("BaseController : didHaveMemoryPressure");
  }

  @override
  void didChangeMetrics() {
    Logger.doLog("BaseController : didChangeMetrics");
  }

  @override
  void didChangeTextScaleFactor() {
    Logger.doLog("BaseController : didChangeTextScaleFactor");
  }
}
