
class AppValidators {
  AppValidators._();

  static String? requiredField(
      String? value, {
        required String fieldName,
      }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }

    return null;
  }

  /// The phone field is entered without the leading zero
  /// because the UI already displays Egypt's +20 country code.
  static String? egyptianPhone(String? value) {
    final phone = value?.trim() ?? '';

    if (phone.isEmpty) {
      return 'رقم الموبايل مطلوب';
    }

    if (!RegExp(r'^(10|11|12|15)\d{8}$').hasMatch(phone)) {
      return 'اكتب رقم صحيح مكوّن من 10 أرقام';
    }

    return null;
  }

  static String? username(String? value) {
    final username = value?.trim() ?? '';

    if (username.isEmpty) {
      return 'اسم المستخدم مطلوب';
    }

    if (username.length < 3 || username.length > 20) {
      return 'اسم المستخدم لازم يكون من 3 إلى 20 حرفًا';
    }

    if (!RegExp(r'^[a-zA-Z0-9_#!-]+$').hasMatch(username)) {
      return 'استخدم الحروف الإنجليزية والأرقام والرموز _ # ! - فقط';
    }

    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (password.length < 8) {
      return 'كلمة المرور لازم تكون 8 أحرف على الأقل';
    }

    if (RegExp(r'\s').hasMatch(password)) {
      return 'كلمة المرور مينفعش تحتوي على مسافات';
    }

    if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return 'كلمة المرور لازم تحتوي على حرف إنجليزي';
    }

    if (!RegExp(r'\d').hasMatch(password)) {
      return 'كلمة المرور لازم تحتوي على رقم';
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String originalPassword,
      ) {
    if (value == null || value.isEmpty) {
      return 'أكد كلمة المرور';
    }

    if (value != originalPassword) {
      return 'كلمتا المرور غير متطابقتين';
    }

    return null;
  }
}
