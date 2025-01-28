import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/presentation/home_screen/view/widget/home_app_bar.dart';
import 'package:flowery_driver/presentation/home_screen/view/widget/home_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/di.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../domain/entity/pending_orders/order_entity.dart';
import '../../../generated/l10n.dart';
import '../view_model/home_states.dart';
import '../view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNotificationEnabled = true;
  late HomeCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
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
      body: BlocBuilder<HomeCubit, HomeState>(
          bloc: viewModel,
          builder: (BuildContext context, state) {
            if (state is PendingOrderLoadingState) {
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
              return SizedBox.shrink();            }
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
                        );
                      }));
            }
            return Center(child: Text(local.noOrdersAvailable));
          }),
    );
  }
}
