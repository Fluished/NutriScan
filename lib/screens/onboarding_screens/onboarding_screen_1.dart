import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class OnboardingScreen1 extends StatefulWidget {
  @override
  _OnboardingScreen1 createState() => _OnboardingScreen1();
}

class _OnboardingScreen1 extends State<OnboardingScreen1> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double halfScreenHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical, // Makes pages scroll UP/DOWN
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          // First Page
          GestureDetector(
            onTap: _nextPage, // Tap to trigger vertical swipe
            child: Container(
              color: AppColors.background,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: TopClipper(),
                          child: Container(
                            height: halfScreenHeight,
                            color: AppColors.clipper,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "NutriScan",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Second Page (With Next Button)
          Container(
            color: AppColors.background,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/landing/landing_asset_1_no_bg.png",
                        height: 200,
                      ),
                    ],
                  ),
                ),
                ClipPath(
                  clipper: BottomClipper(),
                  child: Container(
                    height: halfScreenHeight,
                    color: AppColors.clipper,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 90,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () => AppNavigator.push(context, OnboardingScreen2()),
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),  //Second Page
        ],
      ),
    );
  }
}
