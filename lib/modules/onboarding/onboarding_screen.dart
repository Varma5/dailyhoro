import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboarding_controller.dart';
import '../../constants/app_strings.dart';

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

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the context in the controller for navigation
    final controller = Provider.of<OnboardingController>(
      context,
      listen: false,
    );
    controller.setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingController>(
      builder: (context, controller, child) {
        final pages = controller.pages; // Get pages from controller

        return Scaffold(
          body: Stack(
            children: [
              // Full screen layout without SafeArea
              Column(
                children: [
                  // Image section (70% of screen) - touches the top bezel
                  Expanded(
                    flex: 6,
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.updatePageIndex,
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return _buildImageSection(pages[index]);
                      },
                    ),
                  ),

                  // Content and navigation section (30% of screen)
                  Expanded(
                    flex: 4,
                    child: _buildContentSection(context, controller, pages),
                  ),
                ],
              ),

              // Top section with skip button and progress (overlay)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildTopSection(context, controller, pages.length),
              ),
            ],
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
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
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
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () => controller.skipOnboarding(),
              child: const Text(
                AppStrings.onboardingSkip,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(OnboardingPage page) {
    return Container(
      width: double.infinity,
      child: Image.asset(
        page.imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to icon if image not found
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.2),
            child: Icon(page.icon, size: 100, color: Colors.white),
          );
        },
      ),
    );
  }

  Widget _buildContentSection(
    BuildContext context,
    OnboardingController controller,
    List<OnboardingPage> pages,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: pages[controller.currentPageIndex].color,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // Content area for text
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated title
                TweenAnimationBuilder<double>(
                  key: ValueKey(
                    '${pages[controller.currentPageIndex].title}_title',
                  ),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Text(
                          pages[controller.currentPageIndex].title,
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

                const SizedBox(height: 16),

                // Animated description
                TweenAnimationBuilder<double>(
                  key: ValueKey(
                    '${pages[controller.currentPageIndex].title}_description',
                  ),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Text(
                          pages[controller.currentPageIndex].description,
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
          ),

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

          const SizedBox(height: 24),

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
                      AppStrings.onboardingBack,
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
                    controller.isLastPage
                        ? AppStrings.onboardingGetStarted
                        : AppStrings.onboardingNext,
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
}
