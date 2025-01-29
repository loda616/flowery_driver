import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/widget/custom_button.dart';
import '../../../core/utils/widget/custom_text_form_field.dart';
import '../../../domain/entity/profile/driver_entity.dart';
import '../view_model/profile_states.dart';
import '../view_model/profile_view_model.dart';

class EditVehicleInfoForm extends StatefulWidget {
  EditVehicleInfoForm({
    super.key,
    required this.driver,
    required this.vehicle,
    this.onGenderChanged,
  });

  final ValueChanged<String>? onGenderChanged;
  DriverEntity driver;
  VehicleEntity vehicle;

  @override
  State<EditVehicleInfoForm> createState() => _EditDriverInfoFormState();
}

class _EditDriverInfoFormState extends State<EditVehicleInfoForm> {
  late ProfileCubit viewModel;
  bool hasChanges = false;
  String? selectedVehicleTypeId;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileCubit>();
    selectedVehicleTypeId = widget.driver.vehicleType;
    viewModel.getAllVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              bloc: viewModel..getLoggedUserInfo(),
              buildWhen: (previous, current) {
                return current is GetVehiclesTypeLoading ||
                    current is GetVehiclesTypeSuccess ||
                    current is GetVehiclesTypesError;
              },
              builder: (context, state) {
                if (state is GetVehiclesTypeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetVehiclesTypesError) {
                  return Text(state.errorMessage??"");
                }

                final isSelectedValueValid = viewModel.vehicles
                    .any((vehicle) => vehicle.id == selectedVehicleTypeId);

                return DropdownButtonFormField<String>(
                  value: isSelectedValueValid ? selectedVehicleTypeId : null,
                  items: viewModel.vehicles.map((vehicle) {
                    return DropdownMenuItem<String>(
                      value: vehicle.id,
                      child: Text(vehicle.type ?? ''),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Type',
                    hintText: 'Select Vehicle Type',
                  ),
                  onChanged: (value)  => _checkVehicleChanges(widget.vehicle)
                );
              },
            ),
            24.verticalSpace,
            CustomTextFormField(
              controller: viewModel.vehicleNumberController,
              hintText: widget.driver.vehicleNumber ?? '',
              labelText: "Vehicle Number",
              onChanged: (value) => _checkDriverChanges(widget.driver),
            ),
            24.verticalSpace,
            CustomTextFormField(
              onChanged: (value) => _checkDriverChanges(widget.driver),
              hintText: "photo_1234567",
              labelText: "Vehicle License",
              controller: TextEditingController(),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
            50.verticalSpace,

            CustomButton(
              onPressed: hasChanges
                  ? () async {
                if (viewModel.formKey.currentState!.validate()) {
                  if (selectedVehicleTypeId != widget.driver.vehicleType) {
                    await viewModel.updateVehicleType(selectedVehicleTypeId!);
                  }
                  await viewModel.editeProfile();
                  setState(() {
                    widget.driver.vehicleNumber = viewModel.vehicleNumberController.text;
                    widget.vehicle.type = viewModel.vehicleTypeController.text;
                    hasChanges = false;
                  });
                }
              }
                  : null,
              text: "Update",
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              height: 53.h,
            ),
          ],
        ),
      ),
    );
  }

  void _checkDriverChanges(DriverEntity driver ) {
    setState(() {
      hasChanges = viewModel.vehicleNumberController.text != driver.vehicleNumber ||
          selectedVehicleTypeId != driver.vehicleType ||
      viewModel.vehicleTypeController.text !=driver.vehicleType;
    });
  }
  void _checkVehicleChanges( VehicleEntity vehicle ) {
    setState(() {
      hasChanges = viewModel.vehicleTypeController.text !=vehicle.type;
    });
  }
}
