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
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _goSignUp() => Navigator.pushReplacementNamed(context, AppRoutes.signUp);

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
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
            onSelected: (_) => _goSignUp(),
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'اسم المستخدم',
            hint: '@mohamedmoma02',
            controller: _username,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
          PasswordField(
            controller: _password,
            obscure: _obscure,
            onToggle: () => setState(() => _obscure = !_obscure),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: _goSignUp,
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
          PrimaryButton(label: 'دخول', onPressed: () {}),
        ],
      ),
    );
  }
}
