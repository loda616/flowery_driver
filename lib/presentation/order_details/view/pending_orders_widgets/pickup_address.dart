import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flowery_driver/core/styles/images/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/const/custom_cached_network_image.dart';
import '../../../../domain/entity/pending_orders/Store.dart';

class PickupAddress extends StatelessWidget {
  const PickupAddress({super.key, this.store});
  final Store? store;
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
          children: [
                CustomCachedNetworkImage(
                imageUrl: store?.image,
                width: 55.w,
                height: 55.h,
                shimmerRadiusValue: 0,
                fit: BoxFit.cover,),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store?.name ?? "Unknown Store",
                  style: AppFonts.font16GreyWeight400,
                ),
                5.verticalSpace,
                Row(
                  children: [
                    Image.asset(AppImages.locationIcon),
                    5.horizontalSpace,
                    Text(
                      store?.address ?? "No address",
                      style: AppFonts.font13BlackWeight400,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
