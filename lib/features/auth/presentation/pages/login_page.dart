import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_tab_switcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  bool obscure = true;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void goSignUp() {
    Navigator.pushReplacementNamed(context, AppRoutes.signUp);
  }
  //
  // void submit() {
  //   if (!formKey.currentState!.validate()) return;
  //
  //   FocusScope.of(context).unfocus();
  //
  //   context.read<LoginCubit>().login(
  //     identifier: username.text.trim(),
  //     password: password.text,
  //   );
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
              title: 'أهلاً بيك تاني',
              subtitle: 'ادخل باسم المستخدم وكلمة المرور',
            ),
            const SizedBox(height: 20),
            AuthTabSwitcher(
              selected: AuthTab.login,
              onSelected: (_) => goSignUp(),
            ),
            const SizedBox(height: 16),
            AppTextField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              label: 'اسم المستخدم ',
              hint: '@mohamedmoma02',
              controller: username,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'اكتب اسم المستخدم ';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            PasswordField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: password,
              obscure: obscure,
              onToggle: () {
                setState(() => obscure = !obscure);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'اكتب كلمة المرور';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: goSignUp,
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'مستخدم جديد؟ ',
                      style: TextStyle(color: AppColors.textHint),
                    ),
                    TextSpan(
                      text: 'أنشئ حساب',
                      style: TextStyle(color: AppColors.teal),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'دخول',
              onPressed: () {
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
