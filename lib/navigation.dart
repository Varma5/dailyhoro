import 'package:dailyhoro/modules/onboarding/onboarding_controller.dart';
import 'package:dailyhoro/modules/onboarding/onboarding_screen.dart';
import 'package:dailyhoro/modules/splash/splash_controller.dart';
import 'package:dailyhoro/modules/enter_phone/enter_phone_controller.dart';
import 'package:dailyhoro/modules/enter_phone/enter_phone_screen.dart';
import 'package:dailyhoro/modules/enter_otp/enter_otp_controller.dart';
import 'package:dailyhoro/modules/enter_otp/enter_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/splash/splash_screen.dart';

class AppNavigation {
  AppNavigation._();

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static const String initialRoute = "/";
  static const String onboardRoute = "/onboard";
  static const String enterPhoneRoute = "/enter_phone";
  static const String enterOtpRoute = "/enter_otp";

  static final defaultRoute = MaterialPageRoute(
    builder: (_) => ChangeNotifierProvider(
      create: (context) => SplashController(),
      child: const SplashScreen(),
    ),
  );

  static onRouteGenerated(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        break;
      case onboardRoute:
        return _getPageTransition<OnboardingController>(
          settings: settings,
          page: const OnboardingScreen(),
          controller: OnboardingController(),
        );
      case enterPhoneRoute:
        return _getPageTransition<EnterPhoneController>(
          settings: settings,
          page: const EnterPhoneScreen(),
          controller: EnterPhoneController(),
        );
      case enterOtpRoute:
        final phoneNumber = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => EnterOtpScreen(phoneNumber: phoneNumber ?? ''),
          settings: settings,
        );
      default:
        return defaultRoute;
    }
  }

  static _getPageTransition<T extends ChangeNotifier>({
    required RouteSettings settings,
    required Widget page,
    required T controller,
  }) => MaterialPageRoute(
    builder: (_) =>
        ChangeNotifierProvider(create: (context) => controller, child: page),
    settings: settings,
  );
}
