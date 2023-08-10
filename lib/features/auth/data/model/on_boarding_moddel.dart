import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';

class OnBoardingModdel {
  final String imgPath;
  final String title;
  final String subTitle;

  OnBoardingModdel({
    required this.imgPath,
    required this.title,
    required this.subTitle,
  });
  static List<OnBoardingModdel> OnBoardingScreens = [
    OnBoardingModdel(
        imgPath: AppAssets.on1,
        title: AppStrings.onBoardingTitleOne,
        subTitle: AppStrings.onBoardingSubTitleOne),
    OnBoardingModdel(
        imgPath: AppAssets.on2,
        title: AppStrings.onBoardingTitleTwo,
        subTitle: AppStrings.onBoardingSubTitleTwo),
    OnBoardingModdel(
        imgPath: AppAssets.on3,
        title: AppStrings.onBoardingTitleThree,
        subTitle: AppStrings.onBoardingSubTitleThree),
  ];
}