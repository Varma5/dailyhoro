import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../../navigation.dart';

class EnterOtpController extends ChangeNotifier {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  String _phoneNumber = '';
  bool _isValidOtp = false;
  bool _isLoading = false;
  String? _errorMessage;
  int _remainingTime = 60;
  bool _canResend = false;
  bool _isDisposed = false;
  Timer? _timer;

  // Getters
  String get phoneNumber => _phoneNumber;
  bool get isValidOtp => _isValidOtp;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get remainingTime => _remainingTime;
  bool get canResend => _canResend;

  EnterOtpController({String? phoneNumber}) {
    if (phoneNumber != null) {
      _phoneNumber = phoneNumber;
    }

    // Add listeners to all OTP controllers
    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(_validateOtp);
    }

    _startTimer();
  }

  void _validateOtp() {
    final otp = getOtpCode();
    _errorMessage = null;

    if (otp.length == 6) {
      _isValidOtp = true;
    } else {
      _isValidOtp = false;
    }

    notifyListeners();
  }

  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      // Move to next field
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field
      otpFocusNodes[index - 1].requestFocus();
    }

    _validateOtp();
  }

  void onOtpKeyPressed(String value, int index) {
    if (value.isEmpty && index > 0) {
      // Handle backspace - move to previous field
      otpControllers[index - 1].clear();
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  Future<void> verifyOtp() async {
    if (!_isValidOtp) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final otpCode = getOtpCode();
      print('OTP verification for $_phoneNumber: $otpCode');

      // Here you would typically make an API call to verify OTP
      // For simulation, let's check if OTP is '123456'
      if (otpCode == '123456') {
        // Success - navigate to next screen
        _isLoading = false;
        notifyListeners();

        // Navigate to user details screen
        final context = AppNavigation.navKey.currentContext;
        if (context != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppNavigation.enterDetailsRoute,
            (route) => false,
          );
        }
      } else {
        // Invalid OTP
        _isLoading = false;
        _errorMessage = AppStrings.otpInvalid;
        _clearOtpFields();
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Verification failed. Please try again.';
      notifyListeners();
    }
  }

  Future<void> resendOtp() async {
    if (!_canResend) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      print('Resending OTP to $_phoneNumber');

      // Reset timer and state
      _remainingTime = 60;
      _canResend = false;
      _clearOtpFields();
      _startTimer();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to resend OTP. Please try again.';
      notifyListeners();
    }
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    if (otpFocusNodes.isNotEmpty) {
      otpFocusNodes[0].requestFocus();
    }
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }

      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _canResend = true;
        notifyListeners();
        timer.cancel();
      }
    });
  }

  String get timerText {
    final minutes = _remainingTime ~/ 60;
    final seconds = _remainingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
