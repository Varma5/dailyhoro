import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../../navigation.dart';

class EnterPhoneController extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  String _selectedCountryCode = '+1';
  bool _isValidPhone = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  String get selectedCountryCode => _selectedCountryCode;
  bool get isValidPhone => _isValidPhone;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Common country codes
  final List<Map<String, String>> countryCodes = [
    {'code': '+1', 'country': 'US', 'flag': '🇺🇸'},
    {'code': '+91', 'country': 'IN', 'flag': '🇮🇳'},
    {'code': '+44', 'country': 'UK', 'flag': '🇬🇧'},
    {'code': '+86', 'country': 'CN', 'flag': '🇨🇳'},
    {'code': '+49', 'country': 'DE', 'flag': '🇩🇪'},
    {'code': '+33', 'country': 'FR', 'flag': '🇫🇷'},
    {'code': '+61', 'country': 'AU', 'flag': '🇦🇺'},
    {'code': '+81', 'country': 'JP', 'flag': '🇯🇵'},
  ];

  EnterPhoneController() {
    phoneController.addListener(_validatePhone);
  }

  void setCountryCode(String countryCode) {
    _selectedCountryCode = countryCode;
    _validatePhone();
    notifyListeners();
  }

  void _validatePhone() {
    final phone = phoneController.text.trim();
    _errorMessage = null;

    if (phone.isEmpty) {
      _isValidPhone = false;
    } else if (phone.length < 6) {
      _isValidPhone = false;
      _errorMessage = AppStrings.phoneEntryTooShort;
    } else if (phone.length > 15) {
      _isValidPhone = false;
      _errorMessage = AppStrings.phoneEntryTooLong;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      _isValidPhone = false;
      _errorMessage = AppStrings.phoneEntryInvalidFormat;
    } else {
      _isValidPhone = true;
    }

    notifyListeners();
  }

  String getFullPhoneNumber() {
    return '$_selectedCountryCode${phoneController.text.trim()}';
  }

  Future<void> submitPhoneNumber(BuildContext context) async {
    if (!_isValidPhone) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Here you would typically make an API call to send OTP
      // For now, we'll just simulate success
      final fullNumber = getFullPhoneNumber();
      print('Phone number submitted: $fullNumber');

      // Navigate to OTP verification screen
      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        Navigator.pushNamed(
          context,
          AppNavigation.enterOtpRoute,
          arguments: fullNumber,
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to send verification code. Please try again.';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
