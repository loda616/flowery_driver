import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/order_details_card.dart';
import '../widget/order_status_indicator.dart';
import '../widget/payment_card.dart';
import '../widget/pickup_address_card.dart';
import '../widget/status_card.dart';
import '../widget/total_card.dart';
import '../widget/user_address_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Order Details'),
      ),
      body: Column(
        children: [
          Center(
            child: OrderStatusIndicator(
              currentStatus: OrderStatus.accepted,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    StatusCard(),
                    10.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "Pickup address",
                          style: AppFonts.font18BlackWeight500,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    PickupAddressCard(),
                    10.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "User address",
                          style: AppFonts.font18BlackWeight500,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    UserAddressCard(),
                    10.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "Order Details",
                          style: AppFonts.font18BlackWeight500,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    OrderDetailsCard(),
                    20.verticalSpace,
                    TotalCard(),
                    20.verticalSpace,
                    PaymentCard(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45.h),
                    backgroundColor: AppColors.kPink),
                child: Text(
                  "Arrived At Pickup Point",
                  style: AppFonts.font16WhiteWeight500,
                )),
          )
        ],
      ),
    );
  }
}
