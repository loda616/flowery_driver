import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/images/app_images.dart';

class PersonInfoCard extends StatelessWidget {
  const PersonInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.kLighterGrey, width: 1.w)),
        height: 130.h,
        width: 343.w,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(AppImages.personPhoto)),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "John Doe",
                        style: AppFonts.font18BlackWeight500,
                      ),
                      5.verticalSpace,
                      Text(
                        "John Doe@gmail.com",
                        style: AppFonts.font16BlackWeight400,
                      ),
                      5.verticalSpace,
                      Text(
                        "0123456789",
                        style: AppFonts.font16BlackWeight400,
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.kGray,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
