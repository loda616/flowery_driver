import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kBabyPink,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Status: ",style: AppFonts.font16GreenWeight600,),
                Text("Accepted",style: AppFonts.font16GreenWeight600),

              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Text("Order ID: ",style: AppFonts.font16BlackWeight600,),
                Text("# 123456",style: AppFonts.font16BlackWeight600),

              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Text("wed,03 sep 2024, 11:00 AM ",style: AppFonts.font14GreyWeight500,),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
