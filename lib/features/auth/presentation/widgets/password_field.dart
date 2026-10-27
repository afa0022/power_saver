import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'app_text_field.dart';

/// بتعتمد على AppTextField (composition) بدل ما تكرر الكود.
class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    this.validator,
  });

  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'كلمة المرور',
      hint: '••••••••',
      controller: controller,
      validator: validator,
      obscureText: obscure,
      textInputAction: TextInputAction.done,
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
