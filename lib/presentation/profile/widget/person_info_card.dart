import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../view_model/profile_states.dart';
import '../view_model/profile_view_model.dart';

class PersonInfoCard extends StatefulWidget {
  const PersonInfoCard({super.key});

  @override
  State<PersonInfoCard> createState() => _PersonInfoCardState();
}

class _PersonInfoCardState extends State<PersonInfoCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is GetLoggedDriverInfoLoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) AppDialogs.showLoading(context: context);
          });
        } else if (state is GetLoggedDriverInfoErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              AppDialogs.showErrorDialog(
                context: context,
                errorMassage: state.errorMessage ?? "An Error Occurred",
              );
            }
          });
        } else if (state is GetLoggedDriverInfoSuccessState) {
          return Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border:
                      Border.all(color: AppColors.kLighterGrey, width: 1.w)),
              height: 130.h,
              width: 343.w,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.network(
                            state.driver?.photo ?? AppImages.personPhoto,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CircularProgressIndicator(
                                color: AppColors.kPink,
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(AppImages.personPhoto);
                            },
                          ),
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${state.driver?.firstName ?? "john"} ${state.driver?.lastName ?? "deo"}",
                              style: AppFonts.font18BlackWeight500,
                            ),
                            5.verticalSpace,
                            Text(
                              state.driver?.email ?? "johndeo@gmail.com",
                              style: AppFonts.font16BlackWeight400,
                            ),
                            5.verticalSpace,
                            Text(
                              state.driver?.phone ?? "01063811038",
                              style: AppFonts.font16BlackWeight400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
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
        }
        return Container();
      },
    );
  }
}
