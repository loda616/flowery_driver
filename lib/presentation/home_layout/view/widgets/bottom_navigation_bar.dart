import 'package:flowery_driver/core/styles/images/app_images.dart';
import 'package:flowery_driver/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../core/styles/colors/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return BottomNavigationBar(
      backgroundColor: AppColors.kWhite,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.homeIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 0 ? AppColors.kPink : AppColors.kGray,
              BlendMode.srcIn,
            ),
          ),
          label: local.homebottom,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.ordersIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 1 ? AppColors.kPink : AppColors.kGray,
              BlendMode.srcIn,
            ),
          ),
          label: local.orders,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.personIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? AppColors.kPink : AppColors.kGray,
              BlendMode.srcIn,
            ),
          ),
          label: local.profileText,
        ),
      ],
      selectedItemColor: AppColors.kPink,
      unselectedItemColor: AppColors.kGray,
      unselectedLabelStyle: TextStyle(color: AppColors.kGray),
      selectedFontSize: 15.0.sp,
      iconSize: 22.0.sp,
    );
  }
}
