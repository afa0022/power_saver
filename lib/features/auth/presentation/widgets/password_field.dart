import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'app_text_field.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    this.validator,
    this.label = 'كلمة المرور',
    this.hint = '••••••••',
    this.textInputAction = TextInputAction.done,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final AutovalidateMode autovalidateMode;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;
  final String label;
  final String hint;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      hint: hint,
      controller: controller,
      validator: validator,
      obscureText: obscure,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      suffix: IconButton(
        onPressed: onToggle,
        icon: Icon(
          obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.teal,
          size: 28,
        ),
      ),
    );
  }
}
