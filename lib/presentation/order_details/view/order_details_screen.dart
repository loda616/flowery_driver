import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/entity/pending_orders/order_entity.dart';
import '../view_model/order_details_cubit.dart';
import '../view_model/order_details_state.dart';
import 'order_details_widgets/order_details_card.dart';
import 'order_details_widgets/order_status_indicator.dart';
import 'order_details_widgets/payment_card.dart';
import 'order_details_widgets/pickup_address_card.dart';
import 'order_details_widgets/status_card.dart';
import 'order_details_widgets/total_card.dart';
import 'order_details_widgets/user_address_card.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    super.key,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderDetailsCubit viewModel;
  late List<OrderEntity?> orderEntity;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<OrderDetailsCubit>();
    orderEntity = context.read<OrderDetailsCubit>().orderEntity;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orderId = ModalRoute.of(context)?.settings.arguments as String?;
    if (orderId != null) {
      viewModel.startOrder(orderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrderState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is OrderStateLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.kPink,
            ));
          } else if (state is OrderDetailsError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            });
          } else if (state is OrderDetailsSuccess) {
            final order = state.ordersEntity;
            final orderEntity = viewModel.orderEntity
                .firstWhere((p) => p?.id == order?.id, orElse: () => null);
            print("Order ID: ${order?.id}");
            print("Order date: ${orderEntity?.createdAt}");
            print(" ${viewModel.orderEntity.map((e) => e?.id).toList()}");
            return Scaffold(
              backgroundColor: AppColors.kWhite,
              appBar: AppBar(
                forceMaterialTransparency: true,
                title: const Text('Order Details'),
              ),
              body: Column(
                children: [
                  Center(
                    child: OrderStatusIndicator(
                      currentStep: viewModel.currentStep,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          StatusCard(
                            orderId: order?.orderNumber ?? "",
                            state: order?.state ?? "", orderDate: order?.createdAt??"",
                          ),
                          10.verticalSpace,
                          _buildSectionTitle("Pickup address"),
                          8.verticalSpace,
                          PickupAddressCard(store: orderEntity?.store),
                          10.verticalSpace,
                          _buildSectionTitle("User address"),
                          8.verticalSpace,
                          UserAddressCard(user: orderEntity?.user),
                          10.verticalSpace,
                          _buildSectionTitle("Order Details"),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: order?.orderItems?.length ?? 0,
                            itemBuilder: (context, index) {
                              return OrderDetailsCard(
                                orderItem: orderEntity?.orderItems?[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                10.verticalSpace,
                          ),
                          20.verticalSpace,
                          TotalCard(
                              totalPrice: order?.totalPrice.toString() ?? ""),
                          20.verticalSpace,
                          PaymentCard(
                              paymentType:
                                  state.ordersEntity?.paymentType ?? ""),
                          10.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                            onPressed: viewModel.currentStatus == OrderStatus.delivered
                                ? null
                                : () => viewModel.handleButtonPress(order?.id ?? "", ),

                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 45.h),
                                backgroundColor: AppColors.kPink),
                            child: Text(
                              getButtonText(viewModel.currentStatus),
                              style: AppFonts.font16WhiteWeight500,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            );
          }

          return SizedBox.shrink();
        });
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
}
