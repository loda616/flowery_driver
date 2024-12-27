import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flowery_driver/core/styles/fonts/app_fonts.dart';
import 'package:flowery_driver/presentation/my_profile/widget/logout_row.dart';
import 'package:flowery_driver/presentation/my_profile/widget/person_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/widget/custom_switch_title.dart';
import '../../../generated/l10n.dart';
import '../widget/language_row.dart';
import '../widget/vehicle_info_card.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key});
  bool isNotificationEnabled = true;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          local.profileText,
          style: AppFonts.font20BlackWeight500,
        ),
        leading: Icon(Icons.arrow_back_ios_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomSwitchTitle(
                    activeTrackColor: AppColors.kGreen,
                    value: widget.isNotificationEnabled,
                    title: local.readyForDelivery,
                    titleStyle: AppFonts.font18BlackWeight500,
                    onChanged: (bool newValue) {
                      setState(() {
                        widget.isNotificationEnabled = newValue;
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
      ),
    );
  }
}
