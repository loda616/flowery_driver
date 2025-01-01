import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../view_model/profile_states.dart';
import '../view_model/profile_view_model.dart';

class VehicleInfoCard extends StatefulWidget {
  const VehicleInfoCard({super.key});

  @override
  State<VehicleInfoCard> createState() => _VehicleInfoCardState();
}

class _VehicleInfoCardState extends State<VehicleInfoCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetVehicleInfoLoadingState ||
          current is GetVehicleInfoSuccessState ||
          current is GetVehicleInfoErrorState,
      builder: (context, state) {
        if (state is GetVehicleInfoLoadingState) {
          return SizedBox();
        } else if (state is GetVehicleInfoSuccessState) {
          return Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: AppColors.kLighterGrey, width: 1.w),
              ),
              height: 100.h,
              width: 343.w,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vehicle info",
                          style: AppFonts.font18BlackWeight500,
                        ),
                        5.verticalSpace,
                        Row(
                          children: [
                            Text(
                              state.vehicle?.type ?? "car",
                              style: AppFonts.font16BlackWeight400,
                            ),
                            10.horizontalSpace,
                            Text(
                              context
                                      .read<ProfileCubit>()
                                      .driver
                                      ?.vehicleNumber ??
                                  "123456",
                              style: AppFonts.font16BlackWeight400.copyWith(
                                color: AppColors.kGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.kGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
