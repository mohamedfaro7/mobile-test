import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/main_dashboard_screen.dart';
import '../../features/dashboard/presentation/screens/body_dashboard_screen.dart';
import '../../features/plans/presentation/screens/subscription_plans_screen.dart';
import '../../features/plans/presentation/screens/payment_screen.dart';
import '../../features/nutrition/presentation/screens/meal_plan_screen.dart';
import '../../features/nutrition/presentation/screens/meal_detail_screen.dart';
import '../../features/nutrition/presentation/screens/food_delivery_tracking_screen.dart';
import '../../features/workout/presentation/screens/workout_plan_screen.dart';
import '../../features/workout/presentation/screens/workout_detail_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/change_password_screen.dart';
import '../../features/settings/presentation/screens/language_screen.dart';
import '../../features/settings/presentation/screens/theme_screen.dart';
import '../../features/settings/presentation/screens/help_support_screen.dart';
import '../../features/settings/presentation/screens/about_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_users_screen.dart';
import '../../features/admin/presentation/screens/admin_plans_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_welcome_screen.dart';
import '../../features/profile_setup/presentation/screens/body_measurements_screen.dart';
import '../../features/profile_setup/presentation/screens/fitness_goals_screen.dart';
import '../../features/profile_setup/presentation/screens/diet_preferences_screen.dart';
import '../../features/profile_setup/presentation/screens/activity_level_screen.dart';
import '../../shared/widgets/splash_screen.dart';
import '../../shared/widgets/maintenance_screen.dart';

class AppRouter {
  final Ref _ref;

  AppRouter(this._ref);

  late final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: _routes,
    errorBuilder: (context, state) => const MaintenanceScreen(),
  );

  List<RouteBase> get _routes => [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/maintenance', builder: (_, __) => const MaintenanceScreen()),

    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

    GoRoute(path: '/profile-setup/welcome', builder: (_, __) => const ProfileSetupWelcomeScreen()),
    GoRoute(path: '/profile-setup/measurements', builder: (_, __) => const BodyMeasurementsScreen()),
    GoRoute(path: '/profile-setup/goals', builder: (_, __) => const FitnessGoalsScreen()),
    GoRoute(path: '/profile-setup/diet', builder: (_, __) => const DietPreferencesScreen()),
    GoRoute(path: '/profile-setup/activity', builder: (_, __) => const ActivityLevelScreen()),

    GoRoute(path: '/dashboard', builder: (_, __) => const MainDashboardScreen(navigationShell: null)),
    GoRoute(path: '/body-dashboard', builder: (_, __) => const BodyDashboardScreen()),
    GoRoute(path: '/nutrition', builder: (_, __) => const MealPlanScreen()),
    GoRoute(path: '/meal/:id', builder: (_, state) => MealDetailScreen(mealId: state.pathParameters['id']!)),
    GoRoute(path: '/food-delivery', builder: (_, __) => const FoodDeliveryTrackingScreen()),
    GoRoute(path: '/workout', builder: (_, __) => const WorkoutPlanScreen()),
    GoRoute(path: '/workout/:id', builder: (_, state) => WorkoutDetailScreen(workoutId: state.pathParameters['id']!)),
    GoRoute(path: '/plans', builder: (_, __) => const SubscriptionPlansScreen()),
    GoRoute(path: '/payment/:planId', builder: (_, state) => PaymentScreen(planId: state.pathParameters['planId']!)),
    GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
    GoRoute(path: '/change-password', builder: (_, __) => const ChangePasswordScreen()),
    GoRoute(path: '/language', builder: (_, __) => const LanguageScreen()),
    GoRoute(path: '/theme', builder: (_, __) => const ThemeScreen()),
    GoRoute(path: '/help', builder: (_, __) => const HelpSupportScreen()),
    GoRoute(path: '/about', builder: (_, __) => const AboutScreen()),

    GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardScreen()),
    GoRoute(path: '/admin/users', builder: (_, __) => const AdminUsersScreen()),
    GoRoute(path: '/admin/plans', builder: (_, __) => const AdminPlansScreen()),
  ];
}
