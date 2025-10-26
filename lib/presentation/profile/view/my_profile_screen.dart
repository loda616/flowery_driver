import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../core/utils/widget/custom_switch_title.dart';
import '../../../generated/l10n.dart';
import '../view_model/profile_states.dart';
import '../view_model/profile_view_model.dart';
import '../widget/language_row.dart';
import '../widget/logout_row.dart';
import '../widget/person_info_card.dart';
import '../widget/vehicle_info_card.dart';

class MyProfileScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;

  const MyProfileScreen({super.key, this.onBackPressed});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late ProfileCubit viewModel;
  bool isNotificationEnabled = true;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileCubit>();
    viewModel.getLoggedUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return BlocListener<ProfileCubit, ProfileState>(
        bloc: viewModel..getVehicleInfo(),
        listener: (context, state) {
          if (state is GetLoggedDriverInfoLoadingState) {
            AppDialogs.showLoading(context: context);
          } else if (state is GetLoggedDriverInfoErrorState) {
            AppDialogs.showErrorDialog(
              context: context,
              errorMassage: state.errorMessage ?? "An Error Occurred",
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text(
              local.profileText,
              style: AppFonts.font20BlackWeight500,
            ),
            leading: InkWell(
              onTap: widget.onBackPressed,
              child: Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomSwitchTitle(
                      activeTrackColor: AppColors.kGreen,
                      value: isNotificationEnabled,
                      title: local.readyForDelivery,
                      titleStyle: AppFonts.font18BlackWeight500,
                      onChanged: (bool newValue) {
                        setState(() {
                          isNotificationEnabled = newValue;
                        });
                      },
                    ),
                  ],
                ),
                PersonInfoCard(),
                5.verticalSpace,
                VehicleInfoCard(),
                15.verticalSpace,
                LanguageRow(),
                15.verticalSpace,
                LogoutRow(),
                40.verticalSpace,
                Text(
                  'v 6.3.0 - (446)',
                  style: AppFonts.font11GreyWeight400,
                ),
              ],
            ),
          ),
        ));
  }
}
