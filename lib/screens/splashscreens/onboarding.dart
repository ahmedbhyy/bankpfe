import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/on_boarding_controller.dart';
import '../../widgets/onboarding_widgets/button_continue_splash.dart';
import '../../widgets/onboarding_widgets/custom_slider_onboarding.dart';
import '../../widgets/onboarding_widgets/dot_controller.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  CustomDotControllerOnBoarding(),
                  Spacer(flex: 1),
                  CustomButtonOnBoarding(),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
