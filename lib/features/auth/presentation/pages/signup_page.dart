import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_tab_switcher.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _phone = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _terms = false;

  @override
  void dispose() {
    _phone.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AuthHeader(
            title: 'أهلاً بيك',
            subtitle: 'سجّل عشان تتابع استهلاك الكهربا',
          ),
          const SizedBox(height: 16),
          AuthTabSwitcher(
            selected: AuthTab.signUp,
            onSelected: (_) =>
                Navigator.pushReplacementNamed(context, AppRoutes.login),
          ),
          const SizedBox(height: 14),
          _PhoneRow(controller: _phone),
          const SizedBox(height: 4),
          const Text(
            'هيبعتلك كود تأكيد عليه',
            style: TextStyle(color: AppColors.textHint, fontSize: 12),
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'اسم المستخدم',
            hint: '@mohamedmoma02',
            controller: _username,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          PasswordField(
            controller: _password,
            obscure: _obscure,
            onToggle: () => setState(() => _obscure = !_obscure),
          ),
          const SizedBox(height: 10),
          _TermsRow(
            value: _terms,
            onChanged: (v) => setState(() => _terms = v),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'إرسال كود التحقق',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.otp),
          ),
        ],
      ),
    );
  }
}

class _PhoneRow extends StatelessWidget {
  const _PhoneRow({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'رقم الموبايل',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  hintText: '10X XXX XXXX',
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  filled: true,
                  fillColor: AppColors.field,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  enabledBorder: _border(AppColors.teal.withOpacity(0.6)),
                  focusedBorder: _border(AppColors.teal),
                  errorBorder: _border(AppColors.error),
                  focusedErrorBorder: _border(AppColors.error),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 62,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.field,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.teal.withOpacity(0.6)),
              ),
              alignment: Alignment.center,
              child: const Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    Text(
                      'EG ',
                      style: TextStyle(fontSize: 11, color: AppColors.textHint),
                    ),
                    Text('+20', style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide(color: c, width: 1.2),
  );
}

class _TermsRow extends StatelessWidget {
  const _TermsRow({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            activeColor: AppColors.teal,
            onChanged: (v) => onChanged(v ?? false),
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 11),
              children: [
                TextSpan(
                  text: 'بتسجيل الدخول فإنك توافق على ',
                  style: TextStyle(color: AppColors.textHint),
                ),
                TextSpan(
                  text: 'شروط الاستخدام و سياسة الخصوصية',
                  style: TextStyle(color: AppColors.gold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
