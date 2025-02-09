import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OrderStatusIndicator extends StatelessWidget {
  final int currentStep;

  const OrderStatusIndicator({
    super.key,
    required this.currentStep
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                color: index < currentStep ? AppColors.kGreen : AppColors.kLightGrey,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        );
      }),
    );
  }
}