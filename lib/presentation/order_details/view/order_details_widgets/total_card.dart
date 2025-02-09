import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors/app_colors.dart';


class TotalCard extends StatelessWidget {
  const TotalCard({super.key, required this.totalPrice});
  final String? totalPrice;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
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
            Text("Total",style: AppFonts.font16BlackWeight500,),
            Text("EGP $totalPrice ",
              style: AppFonts.font16BlackWeight500,),

          ],
        ),
      ),
    );
  }
}
