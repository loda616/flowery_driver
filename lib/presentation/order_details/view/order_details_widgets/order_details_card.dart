import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/const/custom_cached_network_image.dart';
import '../../../../domain/entity/pending_orders/order_item.dart';

class OrderDetailsCard extends StatelessWidget {
  final OrderItem? orderItem;
  const OrderDetailsCard({super.key, required this.orderItem});

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
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: CustomCachedNetworkImage(
                      imageUrl: orderItem?.product?.imgCover??"",
                      width: 60.w,
                      height: 60.h,
                      shimmerRadiusValue: 0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          orderItem?.product?.title ?? "Unknown Item",
                          style: AppFonts.font16GreyWeight400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        5.verticalSpace,
                        Text(
                          "EGP ${orderItem?.product?.price ?? '0'}",
                          style: AppFonts.font13BlackWeight400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "x${orderItem?.quantity ?? 1}",
                  style: AppFonts.font16PinkWeight500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
