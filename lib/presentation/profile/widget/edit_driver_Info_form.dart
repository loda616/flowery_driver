import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../core/utils/widget/custom_button.dart';
import '../view_model/profile_view_model.dart';
import 'custom_gender_row.dart';

class EditDriverInfoForm extends StatefulWidget {
  EditDriverInfoForm({
    super.key,
    required this.driver,
    this.gender,
    this.onGenderChanged,
  });

  final ValueChanged<String>? onGenderChanged;
  final String? gender;
  DriverEntity driver;

  @override
  State<EditDriverInfoForm> createState() => _EditDriverInfoFormState();
}

class _EditDriverInfoFormState extends State<EditDriverInfoForm> {
  late ProfileCubit viewModel;
  bool hasChanges = false;
  String? gender;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getLoggedUserInfo();
    gender = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: viewModel.firstNameController,
                    hintText: widget.driver.firstName ?? '',
                    labelText: "First Name",
                    validator: (value) => Validators.validateNotEmpty(
                      value: value,
                      title: "First Name",
                    ),
                    onChanged: (value) => _checkChanges(widget.driver),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: CustomTextFormField(
                    controller: viewModel.lastNameController,
                    hintText: widget.driver.lastName ?? '',
                    labelText: "Last Name",
                    validator: (value) => Validators.validateNotEmpty(
                      value: value,
                      title: "Last Name",
                    ),
                    onChanged: (value) => _checkChanges(widget.driver),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            CustomTextFormField(
              controller: viewModel.emailController,
              hintText: widget.driver.email ?? '',
              labelText: "Email",
              validator: (value) => Validators.validateEmail(value),
              onChanged: (value) => _checkChanges(widget.driver),
            ),
            24.verticalSpace,
            CustomTextFormField(
              controller: viewModel.phoneController,
              hintText: widget.driver.phone ?? '',
              labelText: "Phone",
              validator: (value) => Validators.validatePhoneNumber(value),
              onChanged: (value) => _checkChanges(widget.driver),
            ),
            24.verticalSpace,
            CustomTextFormField(
              onChanged: (value) => _checkChanges(widget.driver),
              hintText: "***********",
              labelText: "",
              controller: TextEditingController(text: "**********"),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
            24.verticalSpace,
            CustomGenderRow(
              gender: gender,
              onChanged: (newGender) {
                setState(() {
                  gender = newGender;
                  widget.onGenderChanged?.call(newGender);
                  _checkChanges(widget.driver);
                });
              },
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: hasChanges
                  ? () async {
                if (viewModel.formKey.currentState!.validate()) {
                  await viewModel.editeProfile();
                  setState(() {
                    widget.driver.firstName =
                        viewModel.firstNameController.text;
                    widget.driver.lastName =
                        viewModel.lastNameController.text;
                    widget.driver.email = viewModel.emailController.text;
                    widget.driver.phone = viewModel.phoneController.text;
                    widget.driver.gender = gender;
                    hasChanges = false;
                  });
                }
              }
                  : null,
              text: "Update",
              textStyle: TextStyle(
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

  void _checkChanges(DriverEntity driver) {
    setState(() {
      hasChanges = viewModel.firstNameController.text != driver.firstName ||
          viewModel.lastNameController.text != driver.lastName ||
          viewModel.emailController.text != driver.email ||
          viewModel.phoneController.text != driver.phone ||
          gender != driver.gender;
    });
  }
}