import 'package:flowery_driver/presentation/orders/view/widget/dashboard.dart';
import 'package:flowery_driver/presentation/orders/view/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/di.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../generated/l10n.dart';
import '../view_model/driver_orders_cubit.dart';
import '../view_model/driver_orders_state.dart';


// orders_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/di.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../generated/l10n.dart';
import '../view_model/driver_orders_cubit.dart';
import '../view_model/driver_orders_state.dart';
import 'widget/dashboard.dart';
import 'widget/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late DriverOrdersCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<DriverOrdersCubit>();
    viewModel.getDriverOrders();
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
      body: BlocBuilder<DriverOrdersCubit, DriverOrdersState>(
        bloc: viewModel,
        builder: (context, state) {
          return Column(
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
                child: _buildOrdersList(state, local),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrdersList(DriverOrdersState state, S local) {
    if (state is DriverOrdersLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.kPink),
      );
    }

    if (state is DriverOrdersError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppDialogs.showErrorDialog(
          context: context,
          errorMassage: state.message,
        );
      });
      return const SizedBox.shrink();
    }

    if (state is DriverOrdersSuccess) {
      return RefreshIndicator(
        color: AppColors.kPink,
        onRefresh: () async {
          viewModel.getDriverOrders();
        },
        child: ListView.builder(
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            final order = state.orders[index];
            if (order == null) return const SizedBox.shrink();

            return OrderCard(
              user: order.order?.user,
              store: order.store,
              order: order,
            );
          },
        ),
      );
    }

    return Center(child: Text(local.noOrdersAvailable));
  }
}