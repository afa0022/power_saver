import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingNextButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const OnboardingNextButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.gold,
          shape: BoxShape.circle,
        ),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(13),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF063C3B),
                ),
              )
            : const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.white,
                size: 25,
              ),
      ),
    );
  }
}
