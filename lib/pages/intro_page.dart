// ignore_for_file: library_private_types_in_public_api

import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meteomuse/functions/arrow.dart';
import 'package:meteomuse/functions/customclippath.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  ui.Image? arrowImage;
 late AnimationController _controller;

  @override
  void initState() {
   super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadArrowImage();
  }
   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadArrowImage() async {
    final data = await rootBundle.load('icons/right-arrow.png');
    final list = Uint8List.view(data.buffer);
    final image = await decodeImageFromList(list);

    setState(() {
      arrowImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildPageContent(
                  title: 'Welcome',
                  description: 'Detailed Hourly Forecast',
                  imagePath: 'assets/images/1.png'),
              _buildPageContent(
                  title: 'Real-Time Weather Map',
                  description: 'This is the second intro page',
                  imagePath: 'assets/images/2.png'),
              _buildPageContent(
                  title: 'Weather Around the World',
                  description: 'This is the third intro page',
                  imagePath: 'assets/images/3.png'),
              _buildPageContent(
                  title: 'Welcome',
                  description: 'This is the first intro page',
                  imagePath: 'assets/images/4.png'),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _currentPage = 4;
                });
                _pageController.jumpToPage(2);
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 320.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleIndicator(_currentPage == 0),
                _buildCircleIndicator(_currentPage == 1),
                _buildCircleIndicator(_currentPage == 2),
                _buildCircleIndicator(_currentPage == 4),
              ],
            ),
          ),
          if (arrowImage != null)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: const Size(80, 80),
                painter: ArrowPainter(
                  progress: (_currentPage + 1) / 3,
                  arrowImage: arrowImage!,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageContent({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              color: Color(0xFF2C2D35),
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        height: 550.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCircleIndicator(_currentPage == 0),
                      _buildCircleIndicator(_currentPage == 1),
                      _buildCircleIndicator(_currentPage == 2),
                      _buildCircleIndicator(_currentPage == 4),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2C2D35),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIndicator(bool isActive) {
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        height: isActive ? 14.0 : 8.0,
        width: isActive ? 16.0 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? const Color(0xFF0A0A22) : Colors.white,
        ),
      ),
    );
  }

}
