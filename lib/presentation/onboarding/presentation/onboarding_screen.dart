import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/widget/custom_button.dart';
import '../../../generated/l10n.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.onBoarding),
              8.verticalSpace,
              Text(
                locale.onboardingMessage,
                style: AppFonts.font20BlackWeight500,
              ),
              24.verticalSpace,
              CustomButton(
                onPressed: () {},
                color: AppColors.kPink,
                text: (locale.loginTitle),
                textStyle: AppFonts.font16LightWhiteWeight500,
              ),
              16.verticalSpace,
              CustomButton(
                onPressed: () {},
                color: AppColors.kWhite,
                text: (locale.applyNow),
                textStyle: AppFonts.font16BlackWeight500,
                borderColor: AppColors.kGray,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 32.h),
        child: Text(
          'v 6.3.0 - (446)',
          style: AppFonts.font11GreyWeight400,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
