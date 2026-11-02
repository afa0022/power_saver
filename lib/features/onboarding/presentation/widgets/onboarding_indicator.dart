import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const OnboardingIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = currentPage == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: isActive ? 9 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.gold : Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}
