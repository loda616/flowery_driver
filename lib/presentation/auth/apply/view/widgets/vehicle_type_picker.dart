import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../domain/entity/vehicles/vehicle_type_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/apply_view_model.dart';

class VehicleTypePicker extends StatelessWidget {
  final ApplyViewModel cubit;
  final Function(VehicleType?)? onChanged;
  final bool isLoading;

  const VehicleTypePicker({
    super.key,
    required this.cubit,
    this.onChanged,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return DropdownButtonFormField<VehicleType>(
      onChanged: onChanged,
      items: cubit.vehicleTypes
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.type ?? '',
                style: AppFonts.font14BlackWeight400,
              ),
            ),
          )
          .toList(),
      borderRadius: BorderRadius.circular(4.r),
      dropdownColor: AppColors.kLightWhite,
      icon: isLoading
          ? SizedBox(
              width: 20.r,
              height: 20.r,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPink),
              ),
            )
          : null,
      decoration: InputDecoration(
        labelText: local.vehicle_type,
        floatingLabelStyle:
            WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.focused)) {
            return TextStyle(color: AppColors.kPink);
          } else if (states.contains(WidgetState.error)) {
            return TextStyle(color: AppColors.kError);
          }
          return TextStyle(color: Colors.grey);
        }),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: local.vehicle_type_hint,
        hintStyle: AppFonts.font14GreyWeight400,
        fillColor: AppColors.kLightWhite,
        filled: true,
        // prefixIcon: widget.prefixIcon,
        // prefixIconColor: AppColors.kPink,

        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: AppColors.kGray,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: AppColors.kGray,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: AppColors.kPink,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: const Color(0xFFE6E6E6),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: AppColors.kError, fontSize: 14.sp),
        errorMaxLines: 4,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: AppColors.kError,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: AppColors.kError,
            width: 1,
          ),
        ),
      ),
    );
  }
}
