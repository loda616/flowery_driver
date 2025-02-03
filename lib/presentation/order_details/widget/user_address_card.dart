import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/styles/images/app_images.dart';

class UserAddressCard extends StatelessWidget {
  const UserAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlack.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(color: AppColors.kLighterGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(child: Image.asset(AppImages.personPhoto)),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nour Mohamed",
                          style: AppFonts.font16GreyWeight400,
                        ),
                        5.verticalSpace,
                        Row(
                          children: [
                            Image.asset(AppImages.locationIcon),
                            5.horizontalSpace,
                            Text(
                              "20th st,Sheikh Zayed,Giza",
                              style: AppFonts.font13BlackWeight400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.kPink,
                    ),
                    5.horizontalSpace,
                    Icon(
                      Icons.message,
                      color: AppColors.kPink,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
