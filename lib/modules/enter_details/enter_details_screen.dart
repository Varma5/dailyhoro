import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_strings.dart';
import '../../../utilities/time_gradient.dart';
import 'enter_details_controller.dart';

class EnterDetailsScreen extends StatelessWidget {
  const EnterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EnterDetailsController(),
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Enable to detect keyboard
        body: Container(
          decoration: BoxDecoration(
            gradient: TimeGradient.getGradientForCurrentTime(),
          ),
          child: SafeArea(
            child: Consumer<EnterDetailsController>(
              builder: (context, controller, child) {
                return Stack(
                  children: [
                    // Scrollable content
                    Positioned.fill(
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom +
                          100, // Adjust for keyboard
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          24.0,
                          24.0,
                          24.0,
                          40.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // Header
                            _buildHeader(),

                            const SizedBox(height: 40),

                            // Form
                            Column(
                              children: [
                                // Full Name
                                _buildTextField(
                                  controller: controller.fullNameController,
                                  label: 'Full Name',
                                  hint: AppStrings.enterDetailsFullNameHint,
                                  icon: Icons.person_outline,
                                ),

                                const SizedBox(height: 24),

                                // Gender Selection
                                _buildGenderSelection(controller),

                                const SizedBox(height: 24),

                                // City of Birth - Hide when keyboard is open
                                if (MediaQuery.of(context).viewInsets.bottom ==
                                    0)
                                  _buildTextField(
                                    controller: controller.cityController,
                                    label: 'City of Birth',
                                    hint: AppStrings.enterDetailsCityHint,
                                    icon: Icons.location_city_outlined,
                                  ),

                                if (MediaQuery.of(context).viewInsets.bottom ==
                                    0)
                                  const SizedBox(height: 24),

                                // Date of Birth
                                _buildDateSelector(context, controller),

                                const SizedBox(height: 20),

                                // Time of Birth
                                _buildTimeSelector(context, controller),

                                const SizedBox(
                                  height: 150,
                                ), // Extra space at bottom for smooth scrolling
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Fixed bottom bar with button
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0xFF11052C).withOpacity(0.8),
                              Color(0xFF11052C),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 24.0,
                            right: 24.0,
                            top: 16.0,
                            bottom:
                                MediaQuery.of(context).padding.bottom + 16.0,
                          ),
                          child: _buildSubmitButton(context, controller),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.nightlight_round,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          AppStrings.enterDetailsTitle,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          AppStrings.enterDetailsSubtitle,
          style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        scrollPadding: const EdgeInsets.all(20.0),
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60, fontSize: 16),
          prefixIcon: Icon(icon, color: Colors.white70, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection(EnterDetailsController controller) {
    return Row(
      children: [
        Expanded(
          child: _buildGenderOption(
            AppStrings.enterDetailsMale,
            Icons.male,
            controller.gender == AppStrings.enterDetailsMale,
            () => controller.setGender(AppStrings.enterDetailsMale),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildGenderOption(
            AppStrings.enterDetailsFemale,
            Icons.female,
            controller.gender == AppStrings.enterDetailsFemale,
            () => controller.setGender(AppStrings.enterDetailsFemale),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.4)
                : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(
    BuildContext context,
    EnterDetailsController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.selectDateOfBirth(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                controller.dateOfBirth != null
                    ? '${controller.dateOfBirth!.day}/${controller.dateOfBirth!.month}/${controller.dateOfBirth!.year}'
                    : AppStrings.enterDetailsSelectDateHint,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.dateOfBirth != null
                      ? Colors.white
                      : Colors.white60,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(
    BuildContext context,
    EnterDetailsController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.selectTimeOfBirth(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.access_time_outlined,
              color: Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                controller.timeOfBirth != null
                    ? controller.timeOfBirth!.format(context)
                    : AppStrings.enterDetailsSelectTimeHint,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.timeOfBirth != null
                      ? Colors.white
                      : Colors.white60,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    EnterDetailsController controller,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.isLoading
            ? null
            : () => controller.submitUserDetails(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
        child: controller.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              )
            : const Text(
                AppStrings.enterDetailsCreateProfileButton,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
