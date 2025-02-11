import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart' show order;
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../domain/entity/drivers_order/order_entity.dart' show OrderEntity;
import '../../../../domain/entity/drivers_order/store_entity.dart' show StoreEntity;
import '../../../../domain/entity/drivers_order/user_entity.dart' show UserEntity;
import '../../../../core/styles/images/app_images.dart';


class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.user,
    required this.store,
    required this.order,
  });

  final UserEntity? user;
  final StoreEntity? store;
  final OrderEntity? order;

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
                offset: const Offset(0, 1),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Flower order",
                      style: AppFonts.font14BlackWeight500,
                    ),
                    Row(
                      children: [
                        _buildStateIndicator(order?.order?.state ?? ''),
                        const SizedBox(width: 8),
                        Text(
                          order?.order?.orderNumber ?? '',
                          style: AppFonts.font14GreyWeight400,
                        ),
                      ],
                    ),
                  ],
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
                _buildStoreCard(),
                10.verticalSpace,
                Text(
                  "User address",
                  style: AppFonts.font14GreyWeight400,
                ),
                5.verticalSpace,
                _buildUserCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateIndicator(String state) {
    IconData icon;
    Color color;
    String text;

    switch (state.toLowerCase()) {
      case 'completed':
        icon = Icons.check_circle_outline;
        color = Colors.green;
        text = 'Completed';
      case 'cancelled':
        icon = Icons.cancel_outlined;
        color = Colors.red;
        text = 'Cancelled';
      case 'inprogress':
        icon = Icons.pending_outlined;
        color = Colors.orange;
        text = 'In Progress';
      default:
        icon = Icons.info_outline;
        color = Colors.grey;
        text = state;
    }

    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppFonts.font14LightGreyWeight500.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildStoreCard() {
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
            offset: const Offset(0, 1),
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
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(AppImages.personPhoto, width: 50, height: 50),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      store?.name ?? "Flowery store",
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
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, color: AppColors.kPink),
                    5.horizontalSpace,
                    Icon(Icons.message, color: AppColors.kPink),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
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
            offset: const Offset(0, 1),
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
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    user?.photo ?? "",
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(AppImages.personPhoto, width: 50, height: 50);
                    },
                  ),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                      style: AppFonts.font16GreyWeight400,
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        Image.asset(AppImages.locationIcon),
                        5.horizontalSpace,
                        const Text(
                          "20th st,Sheikh Zayed,Giza",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, color: AppColors.kPink),
                    5.horizontalSpace,
                    Icon(Icons.message, color: AppColors.kPink),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
