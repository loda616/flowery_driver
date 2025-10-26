import 'package:flowery_driver/core/routes/page_route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../generated/l10n.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({super.key, required this.totalPrice, required this.orderId});
  final String? totalPrice;
  final String? orderId;
  @override
  Widget build(BuildContext context) {
   // final local = S.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "EGP $totalPrice ",
          style: AppFonts.font14BlackWeight600,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(105.w, 40.h),
            backgroundColor: AppColors.kWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
              side: BorderSide(color: AppColors.kPink, width: 1.w),
            ),
          ),
          onPressed: () {},
          child: Text(
            "Reject",
            style: AppFonts.font14PinkWeight500,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(105.w, 40.h),
            backgroundColor: AppColors.kPink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
              side: BorderSide(color: Colors.transparent, width: 1.w),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              PageRouteName.orderDetails,
                 arguments: orderId,
            );
          },
          child: Text("Accept", style: AppFonts.font14LightWhiteWeight500),
        ),
      ],
    );
  }
}
