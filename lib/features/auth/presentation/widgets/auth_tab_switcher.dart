import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum AuthTab { login, signUp }

class AuthTabSwitcher extends StatelessWidget {
  const AuthTabSwitcher({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final AuthTab selected;
  final ValueChanged<AuthTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.field.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        // في RTL أول عنصر على اليمين: إنشاء حساب يمين، تسجيل دخول شمال
        children: [
          _Tab(
            label: 'إنشاء حساب',
            active: selected == AuthTab.signUp,
            onTap: () => onSelected(AuthTab.signUp),
          ),
          _Tab(
            label: 'تسجيل دخول',
            active: selected == AuthTab.login,
            onTap: () => onSelected(AuthTab.login),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: active ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: active ? AppColors.teal : Colors.transparent,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: active ? FontWeight.w700 : FontWeight.w400,
              color: active ? Colors.white : AppColors.textHint,
            ),
          ),
        ),
      ),
    );
  }
}
