import '../../controllers/base_controller.dart';
import '../../navigation.dart';
import '../../utilities/logger.dart';

class SplashController extends BaseController {
  bool _isNavigating = false;

  SplashController() {
    Logger.doLog("SplashController : Constructor called");
    _initialize();
  }

  bool get isNavigating => _isNavigating;

  Future<void> _initialize() async {
    Logger.doLog("SplashController : _initialize started");

    try {
      // Wait for 3 seconds to show splash screen
      await Future.delayed(const Duration(seconds: 3));

      _isNavigating = true;
      notifyListeners();

      final context = AppNavigation.navKey.currentContext;
      if (context != null && context.mounted) {
        await pushNamedRemoveNavigation(context, AppNavigation.onboardRoute);
      } else {
        Logger.doLog("SplashController : Context is null or not mounted");
        _isNavigating = false;
        notifyListeners();
      }
    } catch (e) {
      Logger.doLog("SplashController : Error in initialization: $e");
      _isNavigating = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    Logger.doLog("SplashController : dispose");
    super.dispose();
  }
}
