import 'package:flutter/material.dart';
import '../../controllers/base_controller.dart';

class OnboardingController extends ChangeNotifier {
  late BaseController _baseController;
  int _currentPageIndex = 0;
  bool _isCompleted = false;
  final PageController _pageController = PageController();

  // Getters
  int get currentPageIndex => _currentPageIndex;
  bool get isCompleted => _isCompleted;
  PageController get pageController => _pageController;
  bool get isLastPage => _currentPageIndex == 2; // Assuming 3 pages (0, 1, 2)

  OnboardingController() {
    _baseController = BaseController();
    _initialize();
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

    // Navigate to main app
    // This will be handled by the UI layer
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
