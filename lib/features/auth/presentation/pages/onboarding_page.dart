
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  int currentPage = 0;
  bool isFinishing = false;

  final List<OnboardingData> pages = const [
    OnboardingData(
      image: 'assets/images/onboarding_1.png',
      firstTitle: 'معًا نحو',
      secondTitle: 'استخدام أذكى للطاقة',
      description:
      'تطبيق لمساعدتك على ترشيد استهلاك الكهرباء وتقليل الفاتورة, من أجل مستقبل أكثر استدامة.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_2.png',
      firstTitle: 'تابع استهلاكك',
      secondTitle: 'مع عائلتك',
      description:
      'تقدر تضيف أفراد عائلتك داخل الابليكشن ، واجعل كل فرد يساهم في توفير الطاقة وتقليل الفاتورة.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_3.png',
      firstTitle: 'انضم إلينا',
      secondTitle: '',
      description:'وأبدأ رحلتك نحو استهلاك مسئول واقتصاد مستدام.',

    ),
  ];

  Future<void> finishOnboarding() async {
    if (isFinishing) return;

    setState(() {
      isFinishing = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('onboarding_completed', true);

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.signUp,
      );
    } catch (e, stackTrace) {
      debugPrint('Onboarding Error: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        isFinishing = false;
      });


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ، حاول مرة أخرى'),
        ),
      );
    }
  }

  void nextPage() {
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
                return OnboardingScreen(
                  data: pages[index],
                );
              },
            ),

            // Bottom navigation
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Row(
                children: [
                  // Page indicators
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                            (index) {
                          final isActive = currentPage == index;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            width: isActive ? 9 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFFFC52D)
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Next button
                  GestureDetector(
                    onTap: isFinishing ? null : nextPage,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                      child: isFinishing
                          ? const Padding(
                        padding: EdgeInsets.all(13),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF063C3B),
                        ),
                      )
                          : Icon(
                         Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
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

// Onboarding screen data
class OnboardingData {
  final String image;
  final String firstTitle;
  final String secondTitle;
  final String description;

  const OnboardingData({
    required this.image,
    required this.firstTitle,
    required this.secondTitle,
    required this.description,
  });
}

// Individual onboarding screen
class OnboardingScreen extends StatelessWidget {
  final OnboardingData data;

  const OnboardingScreen({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(
              data.image,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF063C3B),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                );
              },
            ),

            // Dark gradient for readable text
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.35, 0.58, 1.0],
                  colors: [
                    Colors.transparent,
                    Color(0x66001F20),
                    Color(0xFF062D30),
                  ],
                ),
              ),
            ),

            // Text content
            Positioned(
              left: 24,
              right: 24,
              bottom: constraints.maxHeight * 0.17,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.firstTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
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

