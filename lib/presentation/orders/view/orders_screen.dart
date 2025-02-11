import 'package:flowery_driver/presentation/orders/view/widget/dashboard.dart';
import 'package:flowery_driver/presentation/orders/view/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/di.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../generated/l10n.dart';
import '../../order_details/view_model/order_details_cubit.dart';
import '../../order_details/view_model/order_details_state.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrderDetailsCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<OrderDetailsCubit>();
    viewModel.getPendingOrders();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 3),
          const MetricsDashboard(),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Recent orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<OrderDetailsCubit, OrderState>(
              bloc: viewModel,
              builder: (context, state) {
                if (state is OrderStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.kPink),
                  );
                } else if (state is PendingGetOrdersErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppDialogs.showErrorDialog(
                      context: context,
                      errorMassage: state.errorMessage.toString(),
                    );
                  });
                  return const SizedBox.shrink();
                } else if (state is PendingGetOrdersSuccessState) {
                  final orders = state.orders;
                  return RefreshIndicator(
                    color: AppColors.kPink,
                    onRefresh: () async {
                      viewModel.getPendingOrders();
                    },
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        if (order == null) {
                          return const SizedBox.shrink();
                        }
                        return OrderCard(
                          user: order.user,
                          store: order.store,
                          order: order,
                        );
                      },
                    ),
                  );
                }
                return Center(child: Text(local.noOrdersAvailable));
              },
            ),
          ),
        ],
      ),
    );
  }
}