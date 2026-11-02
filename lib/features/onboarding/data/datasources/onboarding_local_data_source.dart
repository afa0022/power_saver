import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalDataSource {
  static const String completedKey = 'onboarding_completed';

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(completedKey) ?? false;
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(completedKey, true);
  }
}
