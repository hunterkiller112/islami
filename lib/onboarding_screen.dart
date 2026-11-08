import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page.dart';
import 'sebha_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int currentPage = 0;
  static const gold = Color(0xffe2be7f);

  Future<void> finishOnboarding() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SebhaScreen()),
    );
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('onboardingSeen', true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var lastPage = currentPage == onboardingPages.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xff202020),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: size.height * 0.17),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingPages.length,
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    var page = onboardingPages[index];
                    return Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/${page.image}',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: gold,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (page.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              page.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: gold,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 76,
                    child: currentPage == 0
                        ? null
                        : TextButton(
                            onPressed: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInSine,
                              );
                            },
                            child: const Text(
                              'Back',
                              style: TextStyle(color: gold),
                            ),
                          ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onboardingPages.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: gold,
                      dotColor: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 76,
                    child: TextButton(
                      onPressed: () {
                        if (lastPage) {
                          finishOnboarding();
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInSine,
                          );
                        }
                      },
                      child: Text(
                        lastPage ? 'Finish' : 'Next',
                        style: const TextStyle(color: gold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
