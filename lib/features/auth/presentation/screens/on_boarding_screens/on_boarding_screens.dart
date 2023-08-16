import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/database/cache/cache_helper.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/utils/widgets/custom_text_button.dart';
import 'package:to_do_app/features/auth/data/model/on_boarding_moddel.dart';
import 'package:to_do_app/features/task/presentation/screens/home_screen.dart';

import '../../../../../core/commons/commons.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/widgets/custom_button.dart';

class OnBoardingScreens extends StatelessWidget {
  OnBoardingScreens({super.key});
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: PageView.builder(
            controller: controller,
            itemCount: OnBoardingModdel.OnBoardingScreens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  //skip text
                  index != 2
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextButton(
                            text: AppStrings.skip,
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                          ),
                        )
                      : const SizedBox(
                          height: 30,
                        ),
                  const SizedBox(
                    height: 19,
                  ),
                  //image
                  Image.asset(
                      OnBoardingModdel.OnBoardingScreens[index].imgPath),
                  const SizedBox(
                    height: 19,
                  ),

                  //dots
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotHeight: 8,
                      // dotWidth: 10,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  //title
                  Text(OnBoardingModdel.OnBoardingScreens[index].title,
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(
                    height: 30,
                  ),

                  //subtitle
                  Text(OnBoardingModdel.OnBoardingScreens[index].subTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(
                    height: 60,
                  ),

                  //buttons
                  Row(
                    children: [
                      //back button
                      index != 0
                          ? CustomTextButton(
                              text: AppStrings.back,
                              onPressed: () {
                                controller.previousPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                            )
                          : Container(),
                      //spacer
                      const Spacer(),
                      //next button
                      index != 2
                          ? CustomButton(
                              text: AppStrings.next,
                              onPressed: () {
                                controller.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                            )
                          : CustomButton(
                              text: AppStrings.getStarted,
                              onPressed: () async {
                                //navigate to home screen
                                await sl<CacheHelper>()
                                    .saveData(
                                        key: AppStrings.onBoardingKey,
                                        value: true)
                                    .then((value) {
                                  print('OnBoarding is Visited');
                                  navigate(context: context, screen: HomeScreen());
                                }).catchError((e) {
                                  print(e.toString());
                                });
                              })
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
