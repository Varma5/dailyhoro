import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final List<OnboardingPage> pages = [
      const OnboardingPage(
        title: "Welcome to DailyHoro",
        description:
            "Discover your daily horoscope and unlock the secrets of the stars",
        icon: Icons.stars,
        color: Colors.purple,
      ),
      const OnboardingPage(
        title: "Daily Predictions",
        description:
            "Get personalized horoscopes based on your zodiac sign every day",
        icon: Icons.calendar_today,
        color: Colors.indigo,
      ),
      const OnboardingPage(
        title: "Cosmic Insights",
        description:
            "Explore detailed astrological insights and guidance for your life",
        icon: Icons.auto_awesome,
        color: Colors.deepPurple,
      ),
    ];

    return Consumer<OnboardingController>(
      builder: (context, controller, child) {
        // Navigate to home when onboarding is completed
        if (controller.isCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigateToHome(context);
          });
        }

        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  pages[controller.currentPageIndex].color.withOpacity(0.8),
                  pages[controller.currentPageIndex].color.withOpacity(0.3),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Top section with skip button and progress
                  _buildTopSection(context, controller, pages.length),

                  // Page view
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.updatePageIndex,
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return _buildPage(pages[index]);
                      },
                    ),
                  ),

                  // Bottom section with indicators and buttons
                  _buildBottomSection(context, controller, pages),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopSection(
    BuildContext context,
    OnboardingController controller,
    int totalPages,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${controller.currentPageIndex + 1} / $totalPages',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Skip button
          TextButton(
            onPressed: () => controller.skipOnboarding(),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    OnboardingController controller,
    List<OnboardingPage> pages,
  ) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: controller.currentPageIndex == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: controller.currentPageIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Navigation buttons
          Row(
            children: [
              // Back button (visible after first page)
              if (controller.currentPageIndex > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => controller.previousPage(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              if (controller.currentPageIndex > 0) const SizedBox(width: 16),

              // Next/Get Started button
              Expanded(
                flex: controller.currentPageIndex > 0 ? 2 : 1,
                child: ElevatedButton(
                  onPressed: () => controller.nextPage(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: pages[controller.currentPageIndex].color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    controller.isLastPage ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon container
          TweenAnimationBuilder<double>(
            key: ValueKey(page.title), // Add key for proper rebuilding
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(page.icon, size: 60, color: Colors.white),
                ),
              );
            },
          ),

          const SizedBox(height: 48),

          // Animated title
          TweenAnimationBuilder<double>(
            key: ValueKey('${page.title}_title'),
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Text(
                    page.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Animated description
          TweenAnimationBuilder<double>(
            key: ValueKey('${page.title}_description'),
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Text(
                    page.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.6,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    // Navigate to home screen
    // Replace this with your actual navigation logic
    Navigator.of(context).pushReplacementNamed('/home');
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
