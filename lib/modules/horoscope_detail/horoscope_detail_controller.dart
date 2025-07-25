import '../../controllers/base_controller.dart';

enum HoroscopeType { daily, weekly, monthly, yearly }

class HoroscopeDetailController extends BaseController {
  final String zodiacSign;

  HoroscopeType _selectedType = HoroscopeType.daily;
  bool _isLoading = false;

  String _dailyHoroscope = '';
  String _weeklyHoroscope = '';
  String _monthlyHoroscope = '';
  String _yearlyHoroscope = '';

  // Getters
  HoroscopeType get selectedType => _selectedType;
  bool get isLoading => _isLoading;
  String get dailyHoroscope => _dailyHoroscope;
  String get weeklyHoroscope => _weeklyHoroscope;
  String get monthlyHoroscope => _monthlyHoroscope;
  String get yearlyHoroscope => _yearlyHoroscope;

  HoroscopeDetailController(this.zodiacSign) {
    loadHoroscopeData();
  }

  void setSelectedType(HoroscopeType type) {
    _selectedType = type;
    notifyListeners();
  }

  String getCurrentHoroscope() {
    switch (_selectedType) {
      case HoroscopeType.daily:
        return _dailyHoroscope;
      case HoroscopeType.weekly:
        return _weeklyHoroscope;
      case HoroscopeType.monthly:
        return _monthlyHoroscope;
      case HoroscopeType.yearly:
        return _yearlyHoroscope;
    }
  }

  String getTypeTitle() {
    switch (_selectedType) {
      case HoroscopeType.daily:
        return 'Daily Horoscope';
      case HoroscopeType.weekly:
        return 'Weekly Horoscope';
      case HoroscopeType.monthly:
        return 'Monthly Horoscope';
      case HoroscopeType.yearly:
        return 'Yearly Horoscope';
    }
  }

  String getDateRange() {
    final now = DateTime.now();
    switch (_selectedType) {
      case HoroscopeType.daily:
        return '${now.day}/${now.month}/${now.year}';
      case HoroscopeType.weekly:
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        return '${weekStart.day}/${weekStart.month} - ${weekEnd.day}/${weekEnd.month}';
      case HoroscopeType.monthly:
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        return '${months[now.month - 1]} ${now.year}';
      case HoroscopeType.yearly:
        return '${now.year}';
    }
  }

  Future<void> loadHoroscopeData() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1200));

      // Generate horoscope content based on zodiac sign
      _dailyHoroscope = _generateDailyHoroscope(zodiacSign);
      _weeklyHoroscope = _generateWeeklyHoroscope(zodiacSign);
      _monthlyHoroscope = _generateMonthlyHoroscope(zodiacSign);
      _yearlyHoroscope = _generateYearlyHoroscope(zodiacSign);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error loading horoscope data: $e');
    }
  }

  String _generateDailyHoroscope(String sign) {
    final horoscopes = {
      'Aries':
          'Today brings fresh energy and new opportunities. Your natural leadership qualities will shine, making it an excellent day for taking initiative. Focus on personal projects and don\'t hesitate to voice your opinions. A conversation with a colleague might lead to unexpected collaboration.',
      'Taurus':
          'Stability and comfort are your themes today. Take time to appreciate the simple pleasures in life. Your practical approach to problems will be highly valued. Consider making a small investment or purchase that brings long-term satisfaction.',
      'Gemini':
          'Communication flows effortlessly today. Your curiosity leads you to interesting discoveries. Multiple opportunities may present themselves - trust your adaptability to handle them all. Social connections prove beneficial.',
      'Cancer':
          'Your intuitive abilities are heightened today. Pay attention to your emotional responses as they guide you toward the right decisions. Family matters may require your nurturing touch. Create a peaceful environment at home.',
      'Leo':
          'Your creative spirit is in full bloom today. Express yourself boldly and don\'t shy away from the spotlight. Others are drawn to your confidence and warmth. A creative project may gain unexpected recognition.',
      'Virgo':
          'Attention to detail serves you well today. Your analytical mind helps solve complex problems. Organization and planning lead to significant progress. Health and wellness deserve your focus.',
      'Libra':
          'Balance and harmony are essential today. Your diplomatic skills help resolve conflicts around you. Aesthetic matters and beautiful surroundings enhance your mood. Relationships require gentle attention.',
      'Scorpio':
          'Deep insights and transformative experiences await. Your investigative nature uncovers hidden truths. Trust your instincts when dealing with complex situations. Emotional depth strengthens your connections.',
      'Sagittarius':
          'Adventure and expansion call to you today. Your optimistic outlook opens new doors. Learning something new or traveling, even short distances, brings joy. Share your wisdom with others.',
      'Capricorn':
          'Your determination and discipline yield concrete results. Professional matters progress steadily. Long-term planning and goal-setting prove beneficial. Recognition for past efforts may come your way.',
      'Aquarius':
          'Innovation and originality set you apart today. Your unique perspective offers solutions others miss. Technology and progressive ideas feature prominently. Community involvement brings satisfaction.',
      'Pisces':
          'Your compassionate nature touches many lives today. Artistic and spiritual pursuits provide deep fulfillment. Trust your dreams and intuitive flashes. Water-related activities or locations prove calming.',
    };
    return horoscopes[sign] ??
        'Today holds special significance for you. Trust your inner wisdom and embrace the opportunities that come your way.';
  }

  String _generateWeeklyHoroscope(String sign) {
    final horoscopes = {
      'Aries':
          'This week emphasizes new beginnings and bold initiatives. Monday and Tuesday are particularly powerful for launching projects. Mid-week brings collaborative opportunities that could lead to long-term partnerships. Weekend activities should focus on physical exercise and outdoor adventures. Your competitive spirit serves you well in professional settings.',
      'Taurus':
          'A week of steady progress and material gains awaits. Financial opportunities emerge around Wednesday. Your persistence in a challenging situation finally pays off. Focus on building security and comfort. Weekend is perfect for indulging in luxury or treating yourself to something special.',
      'Gemini':
          'Communication takes center stage this week. Multiple projects and conversations keep you busy. Tuesday brings an important message or call. Your versatility is your greatest asset. Plan short trips or local exploration for the weekend. Network expansion proves valuable.',
      'Cancer':
          'Emotional depth and family connections dominate this week. Home improvements or family gatherings feature prominently. Your nurturing nature is especially appreciated mid-week. Trust your instincts in financial matters. Weekend activities should center around comfort and familiar surroundings.',
      'Leo':
          'Creative expression and recognition flow abundantly this week. A project or performance gains attention around Thursday. Your leadership skills are in high demand. Romance and entertainment add sparkle to your days. Weekend social events boost your confidence further.',
      'Virgo':
          'Organization and attention to detail bring significant rewards this week. Work projects progress smoothly due to your methodical approach. Health improvements are noticeable by mid-week. Practical solutions to ongoing problems emerge. Weekend is ideal for planning and preparation.',
      'Libra':
          'Relationships and partnerships are highlighted throughout the week. A diplomatic solution to a long-standing issue emerges Tuesday. Your sense of fairness helps others resolve conflicts. Aesthetic pursuits and beauty treatments enhance your well-being. Weekend brings romantic opportunities.',
      'Scorpio':
          'Transformation and deep insights characterize this powerful week. Tuesday\'s revelations change your perspective on an important matter. Your research abilities uncover valuable information. Intimate relationships deepen significantly. Weekend activities should involve mystery or investigation.',
      'Sagittarius':
          'Expansion and adventure fill your week with excitement. A learning opportunity or travel plan develops around Wednesday. Your enthusiasm inspires others to join your endeavors. Cultural activities and philosophical discussions stimulate your mind. Weekend adventures await.',
      'Capricorn':
          'Professional achievement and recognition mark this productive week. A goal you\'ve worked toward reaches completion by Thursday. Your reputation grows stronger through consistent effort. Authority figures acknowledge your capabilities. Weekend success celebrations are in order.',
      'Aquarius':
          'Innovation and progressive thinking shape your week. A technological breakthrough or unique solution emerges Wednesday. Your humanitarian nature attracts like-minded individuals. Group activities and community involvement provide satisfaction. Weekend brings unexpected friendships.',
      'Pisces':
          'Intuition and spiritual growth guide your week. Artistic inspiration flows freely, especially around Tuesday. Your empathetic nature helps others through difficult times. Dreams and meditation provide important guidance. Weekend retreat or water activities restore your energy.',
    };
    return horoscopes[sign] ??
        'This week brings a blend of challenges and opportunities. Your natural strengths will guide you through each situation successfully.';
  }

  String _generateMonthlyHoroscope(String sign) {
    final horoscopes = {
      'Aries':
          'July marks a period of significant personal growth and new ventures. The first half of the month energizes your career sector, bringing opportunities for advancement or new professional directions. Mars, your ruling planet, enhances your drive and determination. Relationships require patience and understanding, especially around the 15th. Financial gains are possible through your own efforts rather than external sources. Health and vitality are strong, making this an excellent time for physical challenges or fitness goals.',
      'Taurus':
          'This month emphasizes stability and material security. Venus blesses your financial sector, bringing opportunities for increased income or valuable acquisitions. The middle weeks are particularly favorable for property matters or home improvements. Relationships deepen through shared values and mutual support. Your natural patience serves you well in negotiations. Focus on building lasting foundations rather than quick fixes.',
      'Gemini':
          'Communication and learning take center stage this month. Multiple opportunities for education, travel, or media involvement emerge. Your versatility opens doors to diverse projects and collaborations. The third week brings particularly exciting news or offers. Social connections multiply, expanding your network significantly. Mental agility and curiosity lead to breakthrough insights.',
      'Cancer':
          'Family and emotional security dominate July\'s themes. Home becomes your sanctuary and source of strength. Intuitive abilities are particularly sharp, guiding important decisions. The lunar influences around mid-month bring emotional clarity and healing. Nurturing activities provide deep satisfaction. Past issues with family members find resolution.',
      'Leo':
          'Creative expression and personal magnetism reach new heights this month. The spotlight finds you naturally, bringing recognition and appreciation. Romance blooms beautifully, especially for those seeking new love. Your leadership qualities attract followers and supporters. Entertainment and leisure activities provide both joy and networking opportunities. Confidence soars to inspiring levels.',
      'Virgo':
          'Practical matters and health improvements characterize July. Your methodical approach yields significant results in work projects. Attention to detail prevents costly mistakes and impresses superiors. The second half of the month favors organizational changes and system improvements. Wellness routines established now have lasting benefits.',
      'Libra':
          'Relationships and partnerships undergo positive transformations this month. Diplomatic skills help resolve long-standing conflicts. Beauty, art, and harmonious surroundings enhance your well-being significantly. Legal matters or contracts conclude favorably. The third week brings a significant relationship milestone or celebration.',
      'Scorpio':
          'Intense transformation and personal power define July. Deep psychological insights emerge, changing your perspective fundamentally. Research and investigation skills uncover valuable secrets or information. Intimate relationships reach new levels of trust and understanding. Financial partnerships or shared resources show promise.',
      'Sagittarius':
          'Adventure and expansion fill July with exciting possibilities. Travel plans materialize, bringing cultural enrichment and new perspectives. Higher education or philosophical studies capture your interest. Publishing or broadcasting opportunities may arise. Your optimistic outlook attracts international connections.',
      'Capricorn':
          'Professional recognition and achievement crown your efforts this month. Authority figures acknowledge your competence and reliability. Long-term goals show substantial progress. The final week brings a significant career milestone or promotion. Discipline and perseverance finally pay visible dividends.',
      'Aquarius':
          'Innovation and humanitarian pursuits dominate July. Unique solutions to complex problems earn recognition and appreciation. Technology plays a significant role in your success. Group activities and community involvement provide deep satisfaction. Friendships evolve into something more meaningful.',
      'Pisces':
          'Spiritual growth and artistic inspiration flow abundantly this month. Creative projects gain momentum and appreciation. Your intuitive abilities guide important life decisions accurately. Water-related activities or locations provide healing and restoration. Compassionate actions create positive karma.',
    };
    return horoscopes[sign] ??
        'This month brings a perfect blend of challenges and opportunities for growth. Trust your instincts and embrace the changes ahead.';
  }

  String _generateYearlyHoroscope(String sign) {
    final horoscopes = {
      'Aries':
          '2025 is your year of pioneering achievements and bold new directions. The first quarter establishes your leadership in a significant area of life. Summer brings romantic fulfillment and creative success. Professional advancement accelerates in autumn, possibly requiring relocation or major lifestyle changes. Your entrepreneurial spirit finds perfect expression. Health remains strong with proper attention to stress management.',
      'Taurus':
          '2025 focuses on building lasting security and deepening roots. Financial growth comes through patient investment and practical decisions. Property matters feature prominently, possibly including a significant purchase or sale. Relationships mature and stabilize, with commitments made around mid-year. Your artistic nature finds profitable expression. Gradual but substantial improvements characterize the year.',
      'Gemini':
          '2025 expands your intellectual horizons and communication networks dramatically. Multiple opportunities for education, travel, and media involvement emerge. Your versatility opens doors to diverse career paths. Technology plays an increasingly important role in your success. Siblings or close friends significantly impact your direction. Mental agility and curiosity drive continuous learning.',
      'Cancer':
          '2025 emphasizes family, home, and emotional security. Real estate transactions or home improvements feature prominently. Your nurturing nature attracts those seeking guidance and support. Intuitive businesses or caring professions show promise. Past emotional wounds heal through understanding and forgiveness. The second half brings profound personal insights.',
      'Leo':
          '2025 is your year to shine brightly and claim your rightful recognition. Creative projects gain significant attention and possibly commercial success. Leadership opportunities emerge naturally from your charismatic presence. Romance reaches fairy-tale proportions for many. Entertainment and leisure activities provide both joy and income. Your generous nature attracts abundance.',
      'Virgo':
          '2025 rewards your methodical approach with tangible improvements across all life areas. Health and wellness routines established now have lifelong benefits. Work efficiency reaches new levels, earning recognition and advancement. Practical investments yield steady returns. Your analytical skills solve complex problems others cannot. Service to others brings deep satisfaction.',
      'Libra':
          '2025 transforms your relationships and brings new partnerships into focus. Legal matters conclude in your favor. Artistic pursuits gain recognition and possibly financial reward. Your diplomatic skills open doors to influential connections. Balance between work and personal life improves significantly. Beauty and harmony surround you increasingly.',
      'Scorpio':
          '2025 brings profound transformation and regeneration to every aspect of your life. Psychological insights lead to powerful personal changes. Hidden resources or talents emerge unexpectedly. Intimate relationships undergo renewal or replacement. Your investigative abilities uncover opportunities others miss. Financial gains through others\' efforts or shared resources.',
      'Sagittarius':
          '2025 expands your world through travel, education, and international connections. Publishing or broadcasting opportunities multiply. Your philosophical outlook attracts students and followers. Adventure and exploration satisfy your wandering spirit. Higher education or advanced training opens new career paths. Cultural exchange enriches your perspective.',
      'Capricorn':
          '2025 crowns your persistent efforts with significant achievement and recognition. Professional advancement reaches new heights. Authority and responsibility increase substantially. Long-term planning shows concrete results. Your reputation for reliability attracts important opportunities. Discipline and patience prove their worth magnificently.',
      'Aquarius':
          '2025 brings technological innovation and humanitarian achievements to the forefront. Your unique vision attracts supporters and funding. Group activities and community involvement expand significantly. Friendships evolve into powerful alliances. Scientific or progressive ideas find practical application. Social reform activities gain momentum.',
      'Pisces':
          '2025 emphasizes spiritual growth and artistic achievement. Creative inspiration flows continuously throughout the year. Your compassionate nature attracts opportunities for healing work. Dreams and intuitive insights guide important decisions. Water-related activities or locations play important roles. Psychic abilities strengthen and find practical use.',
    };
    return horoscopes[sign] ??
        '2025 promises to be a year of significant growth and positive change. Trust your inner wisdom and embrace the opportunities ahead.';
  }

  void refreshData() {
    loadHoroscopeData();
  }
}
