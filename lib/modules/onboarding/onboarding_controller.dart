import 'package:flutter/material.dart';
import '../../controllers/base_controller.dart';
import '../../navigation.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_assets.dart';

class OnboardingController extends ChangeNotifier {
  late BaseController _baseController;
  int _currentPageIndex = 0;
  bool _isCompleted = false;
  final PageController _pageController = PageController();
  BuildContext? _context;

  // Getters
  int get currentPageIndex => _currentPageIndex;
  bool get isCompleted => _isCompleted;
  PageController get pageController => _pageController;
  bool get isLastPage => _currentPageIndex == 2; // Assuming 3 pages (0, 1, 2)

  OnboardingController() {
    _baseController = BaseController();
    _initialize();
  }

  /// Set the build context for navigation
  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> _initialize() async {
    // Initialize any required data or services
    await _loadOnboardingStatus();
  }

  /// Load onboarding completion status from local storage
  Future<void> _loadOnboardingStatus() async {
    // TODO: Implement SharedPreferences or similar to check if onboarding was completed
    // For now, we'll assume it's not completed
    _isCompleted = false;
    notifyListeners();
  }

  /// Update current page index
  void updatePageIndex(int index) {
    if (_currentPageIndex != index) {
      _currentPageIndex = index;
      notifyListeners();
    }
  }

  /// Navigate to next page
  Future<void> nextPage() async {
    if (_currentPageIndex < 2) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await completeOnboarding();
    }
  }

  /// Navigate to previous page
  Future<void> previousPage() async {
    if (_currentPageIndex > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Skip onboarding and go to main app
  Future<void> skipOnboarding() async {
    await completeOnboarding();
  }

  /// Complete onboarding process
  Future<void> completeOnboarding() async {
    _isCompleted = true;
    await _saveOnboardingStatus();
    notifyListeners();

    // Navigate to enter phone screen
    if (_context != null) {
      Navigator.of(
        _context!,
      ).pushReplacementNamed(AppNavigation.enterPhoneRoute);
    } else {
      AppNavigation.navKey.currentState?.pushReplacementNamed(
        AppNavigation.enterPhoneRoute,
      );
    }
  }

  /// Save onboarding completion status
  Future<void> _saveOnboardingStatus() async {
    // TODO: Implement SharedPreferences to save completion status
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('onboarding_completed', true);
  }

  /// Reset onboarding (useful for testing or settings)
  Future<void> resetOnboarding() async {
    _currentPageIndex = 0;
    _isCompleted = false;
    await _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // TODO: Clear SharedPreferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('onboarding_completed', false);

    notifyListeners();
  }

  /// Get progress percentage (0.0 to 1.0)
  double get progress => (_currentPageIndex + 1) / 3;

  /// Get onboarding pages data
  List<OnboardingPage> get pages => [
    const OnboardingPage(
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDesc1,
      icon: Icons.stars,
      color: Colors.black,
      imagePath: AppAssets.imgOnboarding1,
    ),
    const OnboardingPage(
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDesc2,
      icon: Icons.calendar_today,
      color: Colors.black,
      imagePath: AppAssets.imgOnboarding2,
    ),
    const OnboardingPage(
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDesc3,
      icon: Icons.auto_awesome,
      color: Colors.black,
      imagePath: AppAssets.imgOnboarding3,
    ),
  ];

  /// Check if user should see onboarding
  static Future<bool> shouldShowOnboarding() async {
    // TODO: Implement SharedPreferences check
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return !prefs.getBool('onboarding_completed', false);
    return true; // For now, always show onboarding
  }

  @override
  void dispose() {
    _pageController.dispose();
    _baseController.dispose();
    super.dispose();
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String imagePath;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.imagePath,
  });
}
