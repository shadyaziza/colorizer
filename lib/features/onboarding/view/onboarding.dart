import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'widgets/widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IdentityColorFiltered(
            child: OnboardingColumn(),
          ),
        ],
      ),
    );
  }
}
