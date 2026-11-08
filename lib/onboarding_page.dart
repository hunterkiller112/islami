class OnboardingPage {
  String image;
  String title;
  String description;

  OnboardingPage(this.image, this.title, [this.description = '']);
}

List<OnboardingPage> onboardingPages = [
  OnboardingPage('intro_1.png', 'Welcome To Islami App'),
  OnboardingPage(
    'intro_2.png',
    'Welcome To Islami',
    'We Are Very Excited To Have You In Our Community',
  ),
  OnboardingPage(
    'intro_3.png',
    'Reading the Quran',
    'Read, and your Lord is the Most Generous',
  ),
  OnboardingPage(
    'intro_4.png',
    'Sebha',
    'Praise the name of your Lord, the Most High',
  ),
  OnboardingPage(
    'intro_5.png',
    'Holy Quran Radio',
    'You can listen to the Holy Quran Radio through the application for free and easily',
  ),
];
