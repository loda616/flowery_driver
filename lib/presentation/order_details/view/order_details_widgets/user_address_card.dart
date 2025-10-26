import 'package:flowery_driver/presentation/order_details/view/order_details_widgets/pickup_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/const/custom_cached_network_image.dart';
import '../../../../domain/entity/pending_orders/User.dart';

class UserAddressCard extends StatelessWidget {
  const UserAddressCard({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
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
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomCachedNetworkImage(
                      imageUrl: user?.photo,
                      width: 55.w,
                      height: 55.h,
                      shimmerRadiusValue: 0,
                      fit: BoxFit.cover,
                    ),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user?.firstName ?? "Unknown"} ${user?.lastName ?? "User"}",
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
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => callPhone(user?.phone ?? ""),
                      child: Icon(Icons.phone, color: AppColors.kPink, size: 22),
                    ),                    15.horizontalSpace,
                    IconButton(
                      icon: Icon(Icons.message, color: AppColors.kPink, size: 22),
                      onPressed: () => openWhatsApp(user?.phone ?? ""),
                    )
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
