import 'package:expense_tracker/features/auth/presentation/view/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // باكدج النقط

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  // 1. المتحكم في الصفحات (الريموت)
  final PageController _controller = PageController();
  bool isLastPage = false; // عشان نعرف لو وصلنا لآخر صفحة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 2. الجزء اللي بيتحرك (الشرايح)
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2; // إحنا عندنا 3 صفحات (0, 1, 2)
              });
            },
            children: [
              buildPage(
                image: 'assets/images/illustration.png', // الصورة الأولى
                title: 'Note Down Expenses',
                subtitle: 'Daily note your expenses to help manage money',
              ),
              buildPage(
                image:
                    'assets/images/taxi-its-raining-money.png', // الصورة الثانية
                title: 'Simple Money Management',
                subtitle:
                    'Get your notifications or alert when you do the over expenses',
              ),
              buildPage(
                image:
                    'assets/images/taxi-man-got-rich-with-an-idea.png', // الصورة الثالثة
                title: 'Easy to Track and Analyze',
                subtitle:
                    'Tracking your expense help make sure you don\'t overspend',
              ),
            ],
          ),

          // 3. الجزء الثابت (النقط والزرار)
          Container(
            alignment: const Alignment(0, 0.85), // مكان العناصر في الشاشة
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // النقط الزرقاء (Indicator)
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                const SizedBox(height: 30),

                // زرار LET'S GO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (isLastPage) {
                          // السطر اللي كان ناقص هو ده:
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: const Text(
                        'LET\'S GO',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. دالة بناء الصفحة (عشان م نكررش الكود)
  Widget buildPage({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        const SizedBox(height: 40),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
