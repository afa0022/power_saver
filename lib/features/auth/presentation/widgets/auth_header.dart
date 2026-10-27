import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const _BoltLogo(),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800, height: 1.2)),
            ),
            const Icon(Icons.wb_sunny_outlined, size: 24),
          ],
        ),
        const SizedBox(height: 6),
        Text(subtitle,
            style: const TextStyle(color: AppColors.textHint, fontSize: 14)),
      ],
    );
  }
}

class _BoltLogo extends StatelessWidget {
  const _BoltLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gold, AppColors.goldDark],
        ),
      ),
      child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 32),
    );
  }
}
