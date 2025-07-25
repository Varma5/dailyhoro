import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utilities/time_gradient.dart';
import 'horoscope_detail_controller.dart';

class HoroscopeDetailScreen extends StatelessWidget {
  final String zodiacSign;
  final String zodiacSymbol;
  final String zodiacElement;

  const HoroscopeDetailScreen({
    super.key,
    required this.zodiacSign,
    required this.zodiacSymbol,
    required this.zodiacElement,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HoroscopeDetailController(zodiacSign),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: TimeGradient.getGradientForCurrentTime(),
          ),
          child: SafeArea(
            child: Consumer<HoroscopeDetailController>(
              builder: (context, controller, child) {
                return Column(
                  children: [
                    // Header with back button
                    _buildHeader(context),

                    // Content
                    Expanded(
                      child: controller.isLoading
                          ? _buildLoadingState()
                          : _buildContent(controller),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$zodiacSign Horoscope',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    zodiacSymbol,
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Text(
              '$zodiacElement Sign • ${TimeGradient.getTimeOfDayText(DateTime.now().hour)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'Loading your cosmic insights...',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(HoroscopeDetailController controller) {
    return Column(
      children: [
        // Type selector tabs
        _buildTypeSelector(controller),

        const SizedBox(height: 20),

        // Horoscope content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date/Period info
                _buildPeriodInfo(controller),

                const SizedBox(height: 20),

                // Horoscope content card
                _buildHoroscopeCard(controller),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector(HoroscopeDetailController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          _buildTypeTab('Daily', HoroscopeType.daily, controller),
          _buildTypeTab('Weekly', HoroscopeType.weekly, controller),
          _buildTypeTab('Monthly', HoroscopeType.monthly, controller),
          _buildTypeTab('Yearly', HoroscopeType.yearly, controller),
        ],
      ),
    );
  }

  Widget _buildTypeTab(
    String title,
    HoroscopeType type,
    HoroscopeDetailController controller,
  ) {
    final isSelected = controller.selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setSelectedType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodInfo(HoroscopeDetailController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TimeGradient.getTimeBasedAccentColor(
          DateTime.now().hour,
        ).withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TimeGradient.getTimeBasedAccentColor(
            DateTime.now().hour,
          ).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: TimeGradient.getTimeBasedAccentColor(
                DateTime.now().hour,
              ).withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getTypeIcon(controller.selectedType),
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.getTypeTitle(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  controller.getDateRange(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.refreshData(),
            icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHoroscopeCard(HoroscopeDetailController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Cosmic Guidance for $zodiacSign',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            controller.getCurrentHoroscope(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(HoroscopeType type) {
    switch (type) {
      case HoroscopeType.daily:
        return Icons.today;
      case HoroscopeType.weekly:
        return Icons.date_range;
      case HoroscopeType.monthly:
        return Icons.calendar_month;
      case HoroscopeType.yearly:
        return Icons.event_note;
    }
  }
}
