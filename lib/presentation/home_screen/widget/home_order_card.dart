import 'package:flowery_driver/presentation/home_screen/widget/pickup_address.dart';
import 'package:flowery_driver/presentation/home_screen/widget/price_row.dart';
import 'package:flowery_driver/presentation/home_screen/widget/user_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';

class HomeOrderCard extends StatelessWidget {
  const HomeOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Container(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Flower order",
                  style: AppFonts.font14BlackWeight500,
                ),
                3.verticalSpace,
                Text(
                  "24 Km - 30 mins to deliver",
                  style: AppFonts.font14GreyWeight400,
                ),
                10.verticalSpace,
                Text(
                  "Pickup address",
                  style: AppFonts.font14GreyWeight400,
                ),
                5.verticalSpace,

                PickupAddress(),
                10.verticalSpace,
                Text(
                  "User address",
                  style: AppFonts.font14GreyWeight400,
                ),
                5.verticalSpace,

                UserAddress(),
                10.verticalSpace,
                PriceRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
