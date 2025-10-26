import 'package:flutter/cupertino.dart';

import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../generated/l10n.dart';
import 'custom_switch.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AppImages.floweryRider),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomSwitch(
              activeTrackColor: AppColors.kGreen,
              value: isNotificationEnabled,
              title: local.readyForDelivery,
              titleStyle: AppFonts.font12BlackWeight500,
              onChanged: (bool newValue) {
                setState(() {
                  isNotificationEnabled = newValue;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
