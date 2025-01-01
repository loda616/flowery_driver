import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';

class VehicleInfoCard extends StatelessWidget {
  const VehicleInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.kLighterGrey, width: 1.w)),
        height: 140.h,
        width: 343.w,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vehicle info",
                    style: AppFonts.font18BlackWeight500,
                  ),
                  5.verticalSpace,
                  Text(
                    "Bike",
                    style: AppFonts.font16BlackWeight400,
                  ),
                  5.verticalSpace,
                  Text(
                    "UP16DL00007",
                    style: AppFonts.font16BlackWeight400,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.kGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
