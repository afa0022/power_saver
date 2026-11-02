import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/onboarding_data.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingData data;

  const OnboardingScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              data.image,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF063C3B),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.white,
                      size: 45,
                    ),
                  ),
                );
              },
            ),

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.35, 0.58, 1.0],
                  colors: [
                    Colors.transparent,
                    AppColors.nearBlack,
                    AppColors.deepTeal,
                  ],
                ),
              ),
            ),

            Positioned(
              left: 24,
              right: 24,
              bottom: constraints.maxHeight * 0.17 + 45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.firstTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),

                  if (data.secondTitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      data.secondTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.teal,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ],

                  const SizedBox(height: 14),

                  Text(
                    data.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textHint,
                      fontSize: 20,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
