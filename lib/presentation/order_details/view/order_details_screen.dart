import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/di/di.dart';
import '../view_model/order_details_cubit.dart';
import '../view_model/order_details_state.dart';
import '../widget/order_details_card.dart';
import '../widget/order_status_indicator.dart';
import '../widget/payment_card.dart';
import '../widget/pickup_address_card.dart';
import '../widget/status_card.dart';
import '../widget/total_card.dart';
import '../widget/user_address_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrderDetailsCubit>(),
      child: BlocListener<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {
          if (state is OrderDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is OrderStateUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Order status updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            final cubit = context.read<OrderDetailsCubit>();

            return Scaffold(
              backgroundColor: AppColors.kWhite,
              appBar: AppBar(
                forceMaterialTransparency: true,
                title: const Text('Order Details'),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Center(
                        child: OrderStatusIndicator(
                          currentStatus: cubit.currentStatus,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const StatusCard(),
                              10.verticalSpace,
                              _buildSectionTitle("Pickup address"),
                              const PickupAddressCard(),
                              10.verticalSpace,
                              _buildSectionTitle("User address"),
                              const UserAddressCard(),
                              10.verticalSpace,
                              _buildSectionTitle("Order Details"),
                              const OrderDetailsCard(),
                              20.verticalSpace,
                              const TotalCard(),
                              20.verticalSpace,
                              const PaymentCard(),
                              60.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildBottomButton(context, cubit, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: AppFonts.font18BlackWeight500,
        ),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context, OrderDetailsCubit cubit, OrderDetailsState state) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: cubit.currentStatus == OrderStatus.delivered
            ? const SizedBox.shrink()
            : ElevatedButton(
          onPressed: state is OrderDetailsLoading
              ? null
              : () => cubit.handleButtonPress(orderId),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45.h),
            backgroundColor: AppColors.kPink,
          ),
          child: state is OrderDetailsLoading
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Text(
            cubit.getButtonText(),
            style: AppFonts.font16WhiteWeight500,
          ),
        ),
      ),
    );
  }
}


//  void _handleButtonPress(BuildContext context) {
//     context.read<OrderDetailsCubit>().startOrder(orderId);
//   }
// }