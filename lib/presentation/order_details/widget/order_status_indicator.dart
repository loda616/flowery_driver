import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum OrderStatus { accepted, picked, outForDelivery, arrived, delivered }

class OrderStatusIndicator extends StatelessWidget {
  const OrderStatusIndicator({super.key, required this.currentStatus});
  final OrderStatus currentStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStep(status: OrderStatus.accepted, isActive: currentStatus.index >= OrderStatus.accepted.index),
        _buildStep(status: OrderStatus.accepted, isActive: currentStatus.index >= OrderStatus.arrived.index),
        _buildStep(status: OrderStatus.accepted, isActive: currentStatus.index >= OrderStatus.arrived.index),
        _buildStep(status: OrderStatus.accepted, isActive: currentStatus.index >= OrderStatus.arrived.index),
        _buildStep(status: OrderStatus.accepted, isActive: currentStatus.index >= OrderStatus.arrived.index),
      ],
    );
  }
  Widget _buildStep({required OrderStatus status, required bool isActive}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        //  margin: EdgeInsets.symmetric(horizontal: 2),
          height: 5,
          decoration: BoxDecoration(
            color: isActive ? AppColors.kGreen : AppColors.kLightGrey,
            borderRadius: BorderRadius.circular(10.r),
        ),
            ),
      ));
  }
}
