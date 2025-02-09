import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_button.dart';
import '../../../core/utils/widget/custom_text_form_field.dart';
import '../../../domain/entity/profile/driver_entity.dart';
import '../../../domain/entity/vehicles/vehicle_type_entity.dart';
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
  List<VehicleType> vehicle;

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
    viewModel.vehicleNumberController.text = widget.driver.vehicleNumber ?? '';
    viewModel.vehicleLicenseController.text = widget.driver.vehicleLicense ?? '';
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
              bloc: viewModel,
              buildWhen: (previous, current) {
                return current is GetVehiclesTypeLoading ||
                    current is GetVehiclesTypeSuccess ||
                    current is GetVehiclesTypesError;
              },
              builder: (context, state) {
                if (state is GetVehiclesTypeLoading) {
                  return  Center(child: CircularProgressIndicator(
                    backgroundColor: AppColors.kPink,
                  ));
                }
                if (state is GetVehiclesTypesError) {
                  return Text(state.errorMessage ?? "");
                }

                if (viewModel.vehicles.isEmpty) {
                  return const Text("No vehicle types available.");
                }
                return DropdownButtonFormField<String>(
                  value: viewModel.vehicles.any((vehicle) => vehicle.id == selectedVehicleTypeId)
                      ? selectedVehicleTypeId
                      : viewModel.vehicles.first.id,
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
                  onChanged: (value) {
                    setState(() {
                      selectedVehicleTypeId = value;
                      _checkDriverChanges(widget.driver);
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                );
              },
            ),
            24.verticalSpace,
            CustomTextFormField(
              controller: viewModel.vehicleNumberController,
              hintText: widget.driver.vehicleNumber ?? '',
              labelText: "Vehicle Number",
              onChanged: (value) {
                _checkDriverChanges(widget.driver);
              },
            ),

            24.verticalSpace,
            CustomTextFormField(
              controller: viewModel.vehicleLicenseController,
              hintText: widget.driver.vehicleLicense ?? '',
              labelText: "Vehicle License",
              onChanged: (value) => _checkDriverChanges(widget.driver),
            ),
            50.verticalSpace,

            CustomButton(
              onPressed: hasChanges
                  ? () async {
                if (viewModel.formKey.currentState!.validate()) {
                  await viewModel.updateVehicleInfo(
                    viewModel.vehicleNumberController.text,
                    viewModel.vehicleLicenseController.text,
                    selectedVehicleTypeId ?? widget.driver.vehicleType!,
                  );
                  setState(() {
                    widget.driver.vehicleNumber = viewModel.vehicleNumberController.text;
                    widget.driver.vehicleLicense = viewModel.vehicleLicenseController.text;
                    widget.driver.vehicleType = selectedVehicleTypeId;
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

  void _checkDriverChanges(DriverEntity driver) {
    setState(() {
      hasChanges = viewModel.vehicleNumberController.text != driver.vehicleNumber ||
          viewModel.vehicleLicenseController.text != driver.vehicleLicense ||
          selectedVehicleTypeId != driver.vehicleType;
    });
  }
}
