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
  final VehicleType? selectedType;

  const VehicleTypePicker({
    super.key,
    required this.cubit,
    this.onChanged,
    this.isLoading = true,
    this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<VehicleType>(
      value: selectedType,
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
        labelText: 'Vehicle Type',
        hintText: 'Select Vehicle Type',
        // باقي التنسيق ...
      ),
    );
  }
}
