import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/primary_button.dart';
import '../widgets/otp_input.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              icon: const Icon(Icons.chevron_left_rounded, size: 30),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'سيصلك كود على واتساب',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  '010X XXX XXXX',
                  style: TextStyle(color: AppColors.textHint, fontSize: 16),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.edit, size: 14, color: AppColors.textHint),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OtpInput(onChanged: (_) {}),
          ),
          const SizedBox(height: 32),
          PrimaryButton(label: 'تأكيد', expand: false, onPressed: () {}),
          const SizedBox(height: 28),
          const Text(
            'متبعتلكش كود؟',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '00:00 - ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'إعادة الإرسال',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
