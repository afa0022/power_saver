import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../app/routes.dart';
import '../../data/datasources/onboarding_local_data_source.dart';
import '../../data/models/onboarding_data.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/usecases/complete_onboarding_use_case.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  late final CompleteOnboardingUseCase completeOnboardingUseCase;

  int currentPage = 0;
  bool isFinishing = false;

  @override
  void initState() {
    super.initState();

    // Initialize dependencies
    final localDataSource = OnboardingLocalDataSource();
    final repository = OnboardingRepositoryImpl(localDataSource);

    completeOnboardingUseCase = CompleteOnboardingUseCase(repository);
  }

  final List<OnboardingData> pages = const [
    OnboardingData(
      image: 'assets/images/onboarding_1.png',
      firstTitle: 'معًا نحو',
      secondTitle: 'استخدام أذكى للطاقة',
      description: 'تطبيق لمساعدتك على ترشيد استهلاك الكهرباء وتقليل الفاتورة، من أجل مستقبل أكثر استدامة.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_2.png',
      firstTitle: 'تابع استهلاكك',
      secondTitle: 'مع عائلتك',
      description: 'تقدر تضيف أفراد عائلتك داخل الابليكشن، واجعل كل فرد يساهم في توفير الطاقة وتقليل الفاتورة.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_3.png',
      firstTitle: 'انضم إلينا',
      secondTitle: '',
      description: 'وابدأ رحلتك نحو استهلاك مسؤول واقتصاد مستدام.',
    ),
  ];

  Future<void> finishOnboarding() async {
    if (isFinishing) return;

    setState(() {
      isFinishing = true;
    });

    try {
      await completeOnboardingUseCase();

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, AppRoutes.signUp);
    } catch (error, stackTrace) {
      debugPrint('Onboarding Error: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        isFinishing = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('حدث خطأ، حاول مرة أخرى')));
    }
  }

  void nextPage() {
    if (isFinishing) return;

    if (currentPage == pages.length - 1) {
      finishOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF062D30),
      body: SafeArea(
        child: Stack(
          children: [
            // Onboarding pages
            PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingScreen(data: pages[index]);
              },
            ),

            // Bottom navigation
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Row(
                children: [
                  Expanded(
                    child: OnboardingIndicator(
                      currentPage: currentPage,
                      pageCount: pages.length,
                    ),
                  ),
                  OnboardingNextButton(
                    isLoading: isFinishing,
                    onPressed: nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
