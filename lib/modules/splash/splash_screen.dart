import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_controller.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_styles.dart';
import '../../constants/app_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(gradient: AppGradients.purpleGradient),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App icon/logo
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1500),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: _RotatingMoon(),
                        ),
                      );
                    },
                  ),

                  // const SizedBox(height: 40),

                  // App name
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 2000),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: Text(
                            AppStrings.splashAppName,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Tagline
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 2500),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Text(
                            AppStrings.splashTagline,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RotatingMoon extends StatefulWidget {
  @override
  _RotatingMoonState createState() => _RotatingMoonState();
}

class _RotatingMoonState extends State<_RotatingMoon>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Generate multiple transparent layers
        ...List.generate(4, (index) {
          final size = 140.0 - (index * 20);
          final opacity = 0.05 + (index * 0.025);
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(opacity),
            ),
          );
        }),
        // Rotating moon image in the center
        RotationTransition(
          turns: _rotationController,
          child: Image.asset(AppAssets.imgMoon, width: 60, height: 60),
        ),
      ],
    );
  }
}
