import '../../controllers/base_controller.dart';
import '../../constants/app_strings.dart';

class DashboardController extends BaseController {
  String _userName = '';
  String _zodiacSign = '';
  String _zodiacNature = '';
  String _luckyColor = '';
  String _luckyNumber = '';
  String _auspiciousTime = '';
  String _todaysHoroscope = '';
  bool _isLoading = true;

  // Getters
  String get userName => _userName;
  String get zodiacSign => _zodiacSign;
  String get zodiacNature => _zodiacNature;
  String get luckyColor => _luckyColor;
  String get luckyNumber => _luckyNumber;
  String get auspiciousTime => _auspiciousTime;
  String get todaysHoroscope => _todaysHoroscope;
  bool get isLoading => _isLoading;

  // Zodiac signs data
  final Map<String, Map<String, dynamic>> _zodiacData = {
    'Aries': {
      'nature':
          'Bold, ambitious, and energetic. Natural leaders who love challenges and new adventures.',
      'element': 'Fire',
      'symbol': '♈',
    },
    'Taurus': {
      'nature':
          'Reliable, patient, and practical. Love comfort, luxury, and have strong determination.',
      'element': 'Earth',
      'symbol': '♉',
    },
    'Gemini': {
      'nature':
          'Adaptable, curious, and communicative. Quick-witted with a love for learning and socializing.',
      'element': 'Air',
      'symbol': '♊',
    },
    'Cancer': {
      'nature':
          'Intuitive, emotional, and nurturing. Deeply caring with strong family bonds and empathy.',
      'element': 'Water',
      'symbol': '♋',
    },
    'Leo': {
      'nature':
          'Confident, generous, and dramatic. Natural performers who love attention and recognition.',
      'element': 'Fire',
      'symbol': '♌',
    },
    'Virgo': {
      'nature':
          'Analytical, practical, and perfectionist. Detail-oriented with a desire to help others.',
      'element': 'Earth',
      'symbol': '♍',
    },
    'Libra': {
      'nature':
          'Diplomatic, charming, and balanced. Value harmony, beauty, and fair relationships.',
      'element': 'Air',
      'symbol': '♎',
    },
    'Scorpio': {
      'nature':
          'Intense, passionate, and mysterious. Deep thinkers with strong intuition and determination.',
      'element': 'Water',
      'symbol': '♏',
    },
    'Sagittarius': {
      'nature':
          'Adventurous, optimistic, and philosophical. Love freedom, travel, and exploring new ideas.',
      'element': 'Fire',
      'symbol': '♐',
    },
    'Capricorn': {
      'nature':
          'Ambitious, disciplined, and responsible. Goal-oriented with strong leadership qualities.',
      'element': 'Earth',
      'symbol': '♑',
    },
    'Aquarius': {
      'nature':
          'Independent, innovative, and humanitarian. Forward-thinking with unique perspectives.',
      'element': 'Air',
      'symbol': '♒',
    },
    'Pisces': {
      'nature':
          'Compassionate, artistic, and intuitive. Deeply empathetic with rich imagination.',
      'element': 'Water',
      'symbol': '♓',
    },
  };

  DashboardController() {
    loadDashboardData();
  }

  // Calculate zodiac sign based on birth date
  String _calculateZodiacSign(DateTime birthDate) {
    int month = birthDate.month;
    int day = birthDate.day;

    switch (month) {
      case 1: // January
        return day <= 19 ? 'Capricorn' : 'Aquarius';
      case 2: // February
        return day <= 18 ? 'Aquarius' : 'Pisces';
      case 3: // March
        return day <= 20 ? AppStrings.zodiacPisces : AppStrings.zodiacAries;
      case 4: // April
        return day <= 19 ? AppStrings.zodiacAries : AppStrings.zodiacTaurus;
      case 5: // May
        return day <= 20 ? 'Taurus' : 'Gemini';
      case 6: // June
        return day <= 20 ? 'Gemini' : 'Cancer';
      case 7: // July
        return day <= 22 ? 'Cancer' : 'Leo';
      case 8: // August
        return day <= 22 ? 'Leo' : 'Virgo';
      case 9: // September
        return day <= 22 ? 'Virgo' : 'Libra';
      case 10: // October
        return day <= 22 ? 'Libra' : 'Scorpio';
      case 11: // November
        return day <= 21 ? 'Scorpio' : 'Sagittarius';
      case 12: // December
        return day <= 21 ? 'Sagittarius' : 'Capricorn';
      default:
        return 'Aries';
    }
  }

  // Generate random lucky details
  Map<String, String> _generateLuckyDetails() {
    final colors = [
      'Red',
      'Blue',
      'Green',
      'Yellow',
      'Purple',
      'Orange',
      'Pink',
      'Golden',
    ];
    final numbers = ['3', '7', '9', '12', '21', '27', '33', '42'];
    final times = [
      'Morning (6-9 AM)',
      'Afternoon (2-4 PM)',
      'Evening (6-8 PM)',
      'Night (9-11 PM)',
    ];

    colors.shuffle();
    numbers.shuffle();
    times.shuffle();

    return {
      'color': colors.first,
      'number': numbers.first,
      'time': times.first,
    };
  }

  // Generate today's horoscope
  String _generateTodaysHoroscope(String zodiacSign) {
    final horoscopes = {
      'Aries':
          'Today brings new opportunities for leadership. Trust your instincts and take bold action. A conversation with a friend may lead to unexpected insights.',
      'Taurus':
          'Focus on practical matters today. Your patience will be rewarded. Consider making a financial decision that you\'ve been pondering.',
      'Gemini':
          'Communication is key today. Share your ideas and listen to others. A short journey or learning opportunity may present itself.',
      'Cancer':
          'Trust your emotional intuition today. Family matters may need your attention. Create a nurturing environment for yourself and others.',
      'Leo':
          'Your creativity shines bright today. Express yourself boldly and don\'t be afraid to take center stage. Recognition may come your way.',
      'Virgo':
          'Pay attention to details today. Your analytical skills will help solve a problem. Health and wellness should be a priority.',
      'Libra':
          'Seek balance in all areas of life today. A partnership or relationship may need your diplomatic touch. Beauty and harmony surround you.',
      'Scorpio':
          'Deep insights emerge today. Trust your intuition and don\'t be afraid to transform something in your life. Passion guides your actions.',
      'Sagittarius':
          'Adventure calls today. Expand your horizons through learning or travel. Your optimistic outlook inspires others around you.',
      'Capricorn':
          'Focus on your goals today. Hard work and discipline will pay off. A practical decision may lead to long-term success.',
      'Aquarius':
          'Innovation and originality are your strengths today. Think outside the box and embrace your uniqueness. Help others see new possibilities.',
      'Pisces':
          'Trust your dreams and intuition today. Creative inspiration flows freely. Show compassion to someone who needs support.',
    };

    return horoscopes[zodiacSign] ??
        'Today is a day of possibilities. Trust yourself and embrace what comes your way.';
  }

  Future<void> loadDashboardData() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // For demo purposes, using sample data
      // In real app, get this from shared preferences or API
      _userName = 'Welcome User'; // This would come from user data

      // Sample birth date for demo - in real app, get from user profile
      DateTime sampleBirthDate = DateTime(1990, 7, 15);

      _zodiacSign = _calculateZodiacSign(sampleBirthDate);
      _zodiacNature = _zodiacData[_zodiacSign]?['nature'] ?? '';

      final luckyDetails = _generateLuckyDetails();
      _luckyColor = luckyDetails['color']!;
      _luckyNumber = luckyDetails['number']!;
      _auspiciousTime = luckyDetails['time']!;

      _todaysHoroscope = _generateTodaysHoroscope(_zodiacSign);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error loading dashboard data: $e');
    }
  }

  String getZodiacSymbol() {
    return _zodiacData[_zodiacSign]?['symbol'] ?? '⭐';
  }

  String getZodiacElement() {
    return _zodiacData[_zodiacSign]?['element'] ?? 'Unknown';
  }

  void refreshData() {
    loadDashboardData();
  }
}
