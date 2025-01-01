import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../generated/l10n.dart';
import 'custom_list_title.dart';

class LogoutRow extends StatelessWidget {
  const LogoutRow({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return CustomListTile(
      leadingIcon: Icons.logout,
      title: local.logOut,
      trailingIcon: Icons.logout,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.kWhite,
              content: Container(
                width: 260.w,
                height: 155.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15.h),
                    Text(
                      local.logOut,
                      style: AppFonts.font18BlackWeight500
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      local.logoutConfirmationTitle,
                      style: AppFonts.font16BlackWeight500
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(105.w, 40.h),
                            backgroundColor: AppColors.kWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                              side: BorderSide(color: Colors.grey, width: 1.w),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            local.cancelText,
                            style: AppFonts.font14GreyWeight400,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(105.w, 40.h),
                            backgroundColor: AppColors.kPink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                              side: BorderSide(
                                  color: Colors.transparent, width: 1.w),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            //   viewModel.logout();
                          },
                          child: Text(
                            local.logOut,
                            style: AppFonts.font15WhiteWeight500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
