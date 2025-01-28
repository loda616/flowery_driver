import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../domain/entity/pending_orders/User.dart';

class UserAddress extends StatelessWidget {
  const UserAddress({super.key, this.user});
  final User? user;
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
            /*********
            CustomCachedNetworkImage(
              imageUrl: user?.photo,
              width: 70.w,
              height: 70.h,
              shimmerRadiusValue: 0,
              fit: BoxFit.cover,),
                *************/
            Align(child: Image.asset(AppImages.personPhoto)),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                       "${user?.firstName} ${user?.lastName} ",
                  style: AppFonts.font16GreyWeight400,
                ),
                5.verticalSpace,
                Row(
                  children: [
                    Image.asset(AppImages.locationIcon),
                    5.horizontalSpace,
                    Text(user?.phone ?? "No phone number", style: AppFonts.font13BlackWeight400,),
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
