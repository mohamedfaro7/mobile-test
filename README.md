# FitLife - تطبيق اللياقة البدنية والتغذية المتكامل

تطبيق Flutter شامل للياقة البدنية والتغذية مع نظام اشتراكات، تتبع التقدم، توصيل وجبات، ولوحة تحكم إدارية.

## المميزات الرئيسية

### 🏠 للمستخدمين
- **تسجيل دخول/إنشاء حساب** - دعم Email/Password، Google، Apple، Facebook
- **إعداد الملف الشخصي** - قياسات الجسم، أهداف اللياقة، تفضيلات غذائية، مستوى النشاط
- **لوحة تحكم رئيسية** - تتبع السعرات، الماكروز، الماء، التمارين، تقدم الجسم
- **خطط غذائية مخصصة** - وجبات يومية مع تفاصيل الماكروز، جدول مواعيد، بدائل
- **خطط تمارين شخصية** - برامج أسبوعية مع فيديوهات، تتبع المجموعات، فترات الراحة
- **نظام اشتراكات** - 3 خطط (فردي، عائلي حتى 5 أشخاص، مؤسسي حتى 50 شخص)
- **توصيل وجبات** - تتبع حالة الطلب (قيد التحضير، في الطريق، تم التسليم)
- **إشعارات ذكية** - تذكيرات وجبات، تمارين، ماء، تحفيز يومي
- **تحليل الجسم** - BMI، نسبة الدهون، كتلة العضلات، رسوم بيانية للتقدم

### 👨‍💼 للإدارة
- **لوحة تحكم إدارية** - إحصائيات شاملة، مستخدمين، إيرادات، احتفاظ
- **إدارة المستخدمين** - عرض، تعديل، إيقاف، حذف الحسابات
- **إدارة الخطط** - إنشاء/تعديل خطط الاشتراك، المميزات، الأسعار
- **تحليلات مفصلة** - تحويل، تفعيل، جلسة، ارتداد، DAU/WAU/MAU
- **إعدادات النظام** - نسخ احتياطي، صحة النظام، إعدادات عامة

## هيكل المشروع

```
lib/
├── main.dart                          # نقطة البداية
├── core/
│   ├── constants/app_constants.dart   # الثوابت والإعدادات
│   ├── theme/app_theme.dart           # الثيم (فاتح/داكن) مع Material 3
│   ├── router/app_router.dart         # التوجيه مع GoRouter
│   ├── providers/app_providers.dart   # مزودي الحالة (Riverpod)
│   ├── services/                      # الخدمات
│   │   ├── notification_service.dart  # الإشعارات المحلية
│   │   ├── storage_service.dart       # التخزين المحلي (Hive)
│   │   ├── connectivity_service.dart  # مراقبة الاتصال
│   │   ├── auth_service.dart          # المصادقة (Firebase)
│   │   └── api_service.dart           # API calls (Dio)
│   └── models/                        # النماذج المشتركة
├── features/
│   ├── auth/                          # المصادقة
│   ├── profile_setup/                 # إعداد الملف الشخصي
│   ├── dashboard/                     # لوحة التحكم الرئيسية
│   ├── plans/                         # خطط الاشتراك
│   ├── nutrition/                     # التغذية والوجبات
│   ├── workout/                       # التمارين
│   ├── subscription/                  # إدارة الاشتراك
│   ├── notifications/                 # الإشعارات
│   ├── settings/                      # الإعدادات
│   └── admin/                         # لوحة الإدارة
├── shared/
│   ├── widgets/                       # العناصر المشتركة
│   └── models/                        # نماذج البيانات (Freezed)
└── l10n/                              # الترجمة
```

## المتطلبات

- Flutter SDK 3.19+
- Dart 3.3+
- Firebase Project (للإنتاج)
- Android Studio / VS Code
- Xcode (للتطوير على iOS)

## التثبيت والتشغيل

### 1. استنساخ المشروع
```bash
git clone <repository-url>
cd fitness_app
```

### 2. تثبيت التبعيات
```bash
flutter pub get
```

### 3. توليد الكود (Freezed, JsonSerializable, Riverpod Generator)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. إعداد Firebase (للإنتاج)
```bash
# تثبيت FlutterFire CLI
dart pub global activate flutterfire_cli

# تسجيل الدخول
flutterfire login

# تهيئة المشروع
flutterfire configure
```

### 5. تشغيل التطبيق
```bash
# للويب
flutter run -d chrome

# للأندرويد
flutter run -d android

# للـ iOS
flutter run -d ios
```

## التبعيات الرئيسية

| الحزمة | الاستخدام |
|----------|-----------|
| `flutter_riverpod` | إدارة الحالة |
| `go_router` | التوجيه |
| `freezed` | النماذج غير القابلة للتغيير |
| `json_annotation` | التسلسل/إلغاء التسلسل JSON |
| `hive` | قاعدة البيانات المحلية |
| `firebase_auth` | المصادقة |
| `cloud_firestore` | قاعدة البيانات السحابية |
| `firebase_messaging` | الإشعارات السحابية |
| `flutter_local_notifications` | الإشعارات المحلية |
| `fl_chart` | الرسوم البيانية |
| `syncfusion_flutter_gauges` | مقاييس دائرية |
| `flutter_animate` | الحركات |
| `dio` | طلبات HTTP |
| `intl` | التنسيق والتدويل |

## إعدادات مهمة

### Firebase
استبدل القيم في `lib/firebase_options.dart` و `lib/core/constants/app_constants.dart` بمفاتيح مشروعك الحقيقي.

### مفاتيح API المطلوبة
- Firebase API Keys
- Google Maps API Key (للخرائط)
- Google Places API Key
- OneSignal App ID (للإشعارات السحابية)
- RevenueCat API Key (للاشتراكات داخل التطبيق)

## البنية المعمارية

### نمط التصميم: Clean Architecture + Feature-First
- فصل الطبقات: Presentation, Domain, Data
- كل ميزة في مجلد مستقل
- مشاركة الكود المشترك عبر `shared/`

### إدارة الحالة: Riverpod
- `StateNotifierProvider` للحالات المعقدة
- `FutureProvider`/`StreamProvider` للعمليات غير المتزامنة
- `Provider` للخدمات والأدوات

### التوجيه: GoRouter
- توجيه إعلاني مع `ShellRoute` للشاشة الرئيسية
- حراس المسار (Redirect) للمصادقة والصلاحيات
- دعم الروابط العميقة

### قاعدة البيانات المحلية: Hive
- صناديق منفصلة للمستخدم، الإعدادات، الكاش، التمارين، الوجبات، الإشعارات
- دعم End-to-End Encryption للبيانات الحساسة

## التدويل (i18n)
- دعم العربية (RTL) والإنجليزية (LTR)
- ملفات ARB في `lib/l10n/`
- استخدام `intl` للتنسيق (التواريخ، الأرقام، العملات)

## الاختبار
```bash
# اختبارات الوحدة
flutter test

# اختبارات التكامل
flutter test integration_test/

# تغطية الكود
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## البناء للإنتاج

### Android
```bash
flutter build apk --release
# أو
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## المساهمة

1. Fork المشروع
2. إنشاء فرع للميزة (`git checkout -b feature/amazing-feature`)
3. Commit التغييرات (`git commit -m 'Add amazing feature'`)
4. Push للفرع (`git push origin feature/amazing-feature`)
5. فتح Pull Request

## الترخيص

هذا المشروع مرخص تحت رخصة MIT - راجع ملف `LICENSE` للتفاصيل.

## الدعم

للأسئلة والدعم التقني:
- البريد الإلكتروني: support@fitlife.app
- GitHub Issues: [رابط المستودع]/issues

## خارطة الطريق المستقبلية

- [ ] دعم الساعات الذكية (Wear OS, watchOS)
- [ ] ميزة التحديات الجماعية
- [ ] مدرب ذكي بالذكاء الاصطناعي
- [ ] متجر مكملات غذائية مدمج
- [ ] بث مباشر للتمارين
- [ ] دعم المزيد من اللغات
- [ ] وضع عدم الاتصال المحسن
- [ ] تصدير تقارير PDF

---

تم تطويره بـ ❤️ باستخدام Flutter