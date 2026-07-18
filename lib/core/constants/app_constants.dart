import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'FitLife - تطبيق اللياقة المتكامل';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  
  static const List<Locale> supportedLocales = [
    Locale('ar', 'EG'),
    Locale('en', 'US'),
  ];
  
  static const String defaultLanguage = 'ar';
  static const String fallbackLanguage = 'ar';
  
  static const String baseUrl = 'https://api.fitlife.app/api/v1';
  static const String wsUrl = 'wss://api.fitlife.app/ws';
  
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  
  static const Duration snackBarDuration = Duration(seconds: 4);
  static const Duration toastDuration = Duration(seconds: 3);
  
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  static const Duration cacheExpiration = Duration(days: 7);
  static const Duration tokenRefreshThreshold = Duration(minutes: 5);
  
  static const double defaultBorderRadius = 16.0;
  static const double largeBorderRadius = 24.0;
  static const double smallBorderRadius = 8.0;
  
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double smallPadding = 8.0;
  
  static const double defaultElevation = 2.0;
  static const double highElevation = 8.0;
  
  static const String appFontFamily = 'Cairo';
  static const String arabicFontFamily = 'Cairo';
  static const String englishFontFamily = 'Inter';
  
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'webp', 'heic'];
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB
  
  static const List<String> supportedVideoFormats = ['mp4', 'mov', 'avi'];
  static const int maxVideoSizeBytes = 50 * 1024 * 1024; // 50MB
  
  static const int maxNotificationTitleLength = 50;
  static const int maxNotificationBodyLength = 200;
  
  static const Duration workoutReminderInterval = Duration(minutes: 30);
  static const Duration mealReminderInterval = Duration(hours: 3);
  static const Duration waterReminderInterval = Duration(hours: 2);
  
  static const int maxWorkoutDurationMinutes = 180;
  static const int minWorkoutDurationMinutes = 5;
  
  static const double minCalorieGoal = 1000;
  static const double maxCalorieGoal = 5000;
  
  static const double minWeightKg = 30;
  static const double maxWeightKg = 300;
  
  static const double minHeightCm = 100;
  static const double maxHeightCm = 250;
  
  static const int minAge = 13;
  static const int maxAge = 100;
  
  static const List<String> fitnessGoals = [
    'فقدان الوزن',
    'بناء العضلات',
    'الحفاظ على الوزن',
    'تحسين اللياقة',
    'زيادة القوة',
    'تحسين المرونة',
  ];
  
  static const List<String> activityLevels = [
    'خامل (قليل الحركة)',
    'نشاط خفيف (تمارين خفيفة 1-3 أيام/أسبوع)',
    'نشاط متوسط (تمارين متوسطة 3-5 أيام/أسبوع)',
    'نشاط عالي (تمارين قوية 6-7 أيام/أسبوع)',
    'نشاط مكثف (تمارين قوية جداً يومياً أو وظيفة بدنية)',
  ];
  
  static const List<String> dietPreferences = [
    'لا يوجد تفضيل',
    'نباتي',
    'نباتي صارم',
    'كيتو',
    'باليو',
    'متوسطي',
    'قليل الكربوهيدرات',
    'عالي البروتين',
    'خالي من الغلوتين',
    'خالي من الألبان',
    'حلال فقط',
  ];
  
  static const List<String> allergies = [
    'فول سوداني',
    'مكسرات',
    'ألبان',
    'بيض',
    'قمح/غلوتين',
    'صويا',
    'سمك',
    'محار',
    'سمسم',
    'خردل',
    'كرفس',
    'كبريتات',
  ];
  
  static const List<String> workoutTypes = [
    'قوة',
    'كارديو',
    'HIIT',
    'يوغا',
    'بيلاتس',
    'كروس فيت',
    'تمارين وزن الجسم',
    'رفع أثقال',
    'سباحة',
    'جري',
    'دراجة',
    'ملاكمة',
    'رقص',
    'تمارين وظيفية',
  ];
  
  static const List<String> muscleGroups = [
    'صدر',
    'ظهر',
    'كتف',
    'ذراعين',
    'أرجل',
    'بطن',
    'جسم كامل',
  ];
  
  static const List<String> difficultyLevels = [
    'مبتدئ',
    'متوسط',
    'متقدم',
    'محترف',
  ];
  
  static const Map<String, double> activityLevelMultipliers = {
    'خامل (قليل الحركة)': 1.2,
    'نشاط خفيف (تمارين خفيفة 1-3 أيام/أسبوع)': 1.375,
    'نشاط متوسط (تمارين متوسطة 3-5 أيام/أسبوع)': 1.55,
    'نشاط عالي (تمارين قوية 6-7 أيام/أسبوع)': 1.725,
    'نشاط مكثف (تمارين قوية جداً يومياً أو وظيفة بدنية)': 1.9,
  };
  
  static const Map<String, double> goalCalorieAdjustments = {
    'فقدان الوزن': -500,
    'بناء العضلات': 300,
    'الحفاظ على الوزن': 0,
    'تحسين اللياقة': -200,
    'زيادة القوة': 200,
    'تحسين المرونة': -100,
  };
  
  static const String firebaseProjectId = 'fitlife-app';
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';
  static const String firebaseAppId = 'YOUR_FIREBASE_APP_ID';
  static const String firebaseMessagingSenderId = 'YOUR_SENDER_ID';
  
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String googlePlacesApiKey = 'YOUR_GOOGLE_PLACES_API_KEY';
  
  static const String onesignalAppId = 'YOUR_ONESIGNAL_APP_ID';
  static const String onesignalRestApiKey = 'YOUR_ONESIGNAL_REST_API_KEY';
  
  static const String revenueCatApiKey = 'YOUR_REVENUECAT_API_KEY';
  
  static const String sentryDsn = 'YOUR_SENTRY_DSN';
  
  static const String appStoreId = 'YOUR_APP_STORE_ID';
  static const String playStoreId = 'com.fitlife.app';
  
  static const Duration sessionTimeout = Duration(minutes: 30);
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);
  
  static const String privacyPolicyUrl = 'https://fitlife.app/privacy';
  static const String termsOfServiceUrl = 'https://fitlife.app/terms';
  static const String supportEmail = 'support@fitlife.app';
  static const String feedbackEmail = 'feedback@fitlife.app';
  
  static const List<String> onboardingImages = [
    'assets/images/onboarding_1.png',
    'assets/images/onboarding_2.png',
    'assets/images/onboarding_3.png',
    'assets/images/onboarding_4.png',
  ];
  
  static const List<String> onboardingTitles = [
    'مرحباً بك في FitLife',
    'خطط غذائية مخصصة',
    'تمارين موجهة',
    'تتبع تقدمك',
  ];
  
  static const List<String> onboardingDescriptions = [
    'تطبيق شامل للياقة البدنية والتغذية يساعدك على تحقيق أهدافك الصحية',
    'خطط وجبات مخصصة حسب أهدافك وحالتك الصحية وتفضيلاتك الغذائية',
    'برامج تمارين متنوعة تناسب مستواك وأهدافك مع فيديوهات توضيحية',
    'تتبع تقدمك يومياً وأسبوعياً وشهرياً مع رسوم بيانية تفصيلية',
  ];
}
