import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/validators/app_validators.dart';
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
  final phone = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscure = true;
  bool obscureConfirm = true;
  bool terms = false;

  @override
  void dispose() {
    phone.dispose();
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  // void submit() {
  //
  // }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: formKey,
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
              onSelected: (_) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
            const SizedBox(height: 14),

            PhoneRow(controller: phone, validator: AppValidators.egyptianPhone),
            const SizedBox(height: 4),

            const Text(
              'هيبعتلك كود تأكيد عليه',
              style: TextStyle(color: AppColors.textHint, fontSize: 12),
            ),
            const SizedBox(height: 10),

            AppTextField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              label: 'اسم المستخدم',
              hint: '@mohamedmoma02',
              controller: username,
              validator: AppValidators.username,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),

            PasswordField(
              controller: password,
              obscure: obscure,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onToggle: () {
                setState(() => obscure = !obscure);
              },
              validator: AppValidators.password,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),

            PasswordField(
              label: 'تأكيد كلمة المرور',
              hint: 'أعد كتابة كلمة المرور',
              controller: confirmPassword,
              obscure: obscureConfirm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onToggle: () {
                setState(() {
                  obscureConfirm = !obscureConfirm;
                });
              },
              validator: (value) =>
                  AppValidators.confirmPassword(value, password.text),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 10),

            TermsRow(
              value: terms,
              onChanged: (value) {
                setState(() => terms = value);
              },
            ),
            const SizedBox(height: 14),

            PrimaryButton(
              label: 'إرسال كود التحقق',
              onPressed: () {
                final isValid = formKey.currentState!.validate();

                if (!isValid) return;

                if (!terms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.gold,
                      content: Text('يجب الموافقة على شروط الاستخدام أولاً'),
                    ),
                  );
                  return;
                }

                Navigator.pushNamed(context, AppRoutes.otp);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneRow extends StatelessWidget {
  const PhoneRow({required this.controller, required this.validator});

  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                validator: validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  border: border(AppColors.fieldBorder.withOpacity(0.6)),
                  enabledBorder: border(AppColors.fieldBorder.withOpacity(0.6)),
                  focusedBorder: border(AppColors.teal),
                  errorBorder: border(AppColors.error),
                  focusedErrorBorder: border(AppColors.error),
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
                  mainAxisSize: MainAxisSize.min,
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

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}

class TermsRow extends StatelessWidget {
  const TermsRow({required this.value, required this.onChanged});

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
            onChanged: (value) => onChanged(value ?? false),
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
                  style: TextStyle(
                    color: AppColors.textHint,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'شروط الاستخدام وسياسة الخصوصية',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
