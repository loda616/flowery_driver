import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum OrderStatus {
  accepted,
  picked,
  outForDelivery,
  arrived,
  delivered
}

class OrderStatusIndicator extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderStatusIndicator({
    super.key,
    required this.currentStatus
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: OrderStatus.values.map((status) {
        final isActive = status.index <= currentStatus.index;
        return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.kGreen : AppColors.kLightGrey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            )
        );
      }).toList(),
    );
  }
}
