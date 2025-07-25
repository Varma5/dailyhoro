import 'package:flutter/material.dart';
import '../../../controllers/base_controller.dart';
import '../../../constants/app_strings.dart';

class EnterDetailsController extends BaseController {
  // Form Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  // User Details State
  String _gender = '';
  DateTime? _dateOfBirth;
  TimeOfDay? _timeOfBirth;
  bool _isLoading = false;

  // Getters
  String get gender => _gender;
  DateTime? get dateOfBirth => _dateOfBirth;
  TimeOfDay? get timeOfBirth => _timeOfBirth;
  bool get isLoading => _isLoading;

  // Form validation
  bool get isFormValid {
    return fullNameController.text.trim().isNotEmpty &&
        _gender.isNotEmpty &&
        _dateOfBirth != null &&
        _timeOfBirth != null &&
        cityController.text.trim().isNotEmpty;
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void setDateOfBirth(DateTime date) {
    _dateOfBirth = date;
    notifyListeners();
  }

  void setTimeOfBirth(TimeOfDay time) {
    _timeOfBirth = time;
    notifyListeners();
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _dateOfBirth ??
          DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _dateOfBirth) {
      setDateOfBirth(picked);
    }
  }

  Future<void> selectTimeOfBirth(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfBirth ?? const TimeOfDay(hour: 12, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _timeOfBirth) {
      setTimeOfBirth(picked);
    }
  }

  Future<void> submitUserDetails(BuildContext context) async {
    if (!isFormValid) {
      showSnackBar(context, AppStrings.enterDetailsFormIncomplete);
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call to save user details
      await Future.delayed(const Duration(seconds: 2));

      // Create user details object
      final userDetails = {
        'fullName': fullNameController.text.trim(),
        'gender': _gender,
        'dateOfBirth': _dateOfBirth!.toIso8601String(),
        'timeOfBirth': '${_timeOfBirth!.hour}:${_timeOfBirth!.minute}',
        'cityOfBirth': cityController.text.trim(),
      };

      print('User Details: $userDetails');

      _isLoading = false;
      notifyListeners();

      // Show success message
      showSnackBar(context, AppStrings.enterDetailsProfileCreated);

      // Navigate to dashboard
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashboard',
        (route) => false,
      );
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      showSnackBar(context, 'Error creating profile. Please try again.');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
