import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/presentation/order_details/view/pending_orders_widgets/home_app_bar.dart';
import 'package:flowery_driver/presentation/order_details/view/pending_orders_widgets/home_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/di.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../domain/entity/pending_orders/order_entity.dart';
import '../../../generated/l10n.dart';
import '../view_model/order_details_cubit.dart';
import '../view_model/order_details_state.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  bool isNotificationEnabled = true;
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
        automaticallyImplyLeading: false,
        title: HomeAppBar(),
      ),
      body: BlocBuilder<OrderDetailsCubit, OrderState>(
          bloc: viewModel,
          builder: (BuildContext context, state) {
            if (state is OrderStateLoading) {
              return Center(
                  child: CircularProgressIndicator(color: AppColors.kPink));
            }
            else if (state is PendingGetOrdersErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppDialogs.showErrorDialog(
                  context: context,
                  errorMassage: state.errorMessage.toString(),
                );
              });
              return SizedBox.shrink();
            }
            else if (state is PendingGetOrdersSuccessState) {
              List<OrderEntity?> orders = state.orders;
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
                          return SizedBox.shrink();
                        }
                        return HomeOrderCard(
                          user: order.user,
                          store: order.store,
                          order: order,
                        );
                      }));
            }
            return Center(child: Text(local.noOrdersAvailable));
          }),
    );
  }
}
