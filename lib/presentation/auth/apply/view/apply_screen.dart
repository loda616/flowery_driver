import 'dart:io';
import 'package:flowery_driver/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/extensions/navigation_ext.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/country_picker.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../data/model/auth/requests/apply_request_model.dart';
import '../../../../domain/entity/auth/applu.dart';
import '../../../../generated/l10n.dart';
import '../view_model/apply_view_model.dart';
import 'widgets/vehicle_type_picker.dart';

class ApplyScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  late final ApplyViewModel cubit;
  final _formKey = GlobalKey<FormState>();
  String _gender = '';
  final vehicleLicenseController = TextEditingController();
  final idImageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    cubit = context.read<ApplyViewModel>();
    cubit.getAllVehiclesType();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocListener<ApplyViewModel, ApplyState>(
      bloc: cubit,
      listener: (context, state) => _handelStateChange(state),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          leadingWidth: 40.w,
          title: Text(
            local.applyNow,
            style: AppFonts.font20BlackWeight500,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    local.welcome,
                    style: AppFonts.font20BlackWeight500,
                  ),
                  Text(
                    local.wantToBeDelivery,
                    style: AppFonts.font16GreyWeight500,
                  ),
                  Text(
                    local.joinOurTeam,
                    style: AppFonts.font16GreyWeight500,
                  ),
                  24.verticalSpace,
                  CountryInputField(
                    onInputChanged: (value) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          cubit.countryController.text = value!;
                        });
                      });
                    },
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: cubit.firstLegalNameController,
                    labelText: local.firstLegalName,
                    hintText: local.firstLegalHintName,
                    validator: (value) => Validators.validateNotEmpty(
                      title: local.firstLegalName,
                      value: value,
                    ),
                    keyBordType: TextInputType.text,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: cubit.secondLegalNameController,
                    hintText: local.secondLegalHintName,
                    labelText: local.secondLegalName,
                    validator: (value) => Validators.validateNotEmpty(
                      title: local.secondLegalName,
                      value: value,
                    ),
                    keyBordType: TextInputType.text,
                  ),
                  24.verticalSpace,
                  BlocBuilder<ApplyViewModel, ApplyState>(
                      bloc: cubit,
                      buildWhen: (previous, current) {
                        return current is GetVehiclesTypesLoading ||
                            current is GetVehiclesTypesSuccess ||
                            current is GetVehiclesTypesFail;
                      },
                      builder: (context, state) {
                        bool isLoading = true;
                        if (state is GetVehiclesTypesLoading) {
                          isLoading = true;
                        } else if (state is GetVehiclesTypesSuccess) {
                          isLoading = false;
                        } else if (state is GetVehiclesTypesSuccess) {
                          isLoading = false;
                        }
                        return VehicleTypePicker(
                          isLoading: isLoading,
                          cubit: cubit,
                          onChanged: (value) {
                            cubit.vehicleTypeController.text = value?.id ?? '';
                          },
                        );
                      }),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: cubit.vehicleNumberController,
                    hintText: local.vehicle_number_hint,
                    labelText: local.vehicle_number,
                    validator: (value) => Validators.validateNotEmpty(
                      title: local.vehicle_number,
                      value: value,
                    ),
                    keyBordType: TextInputType.text,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.vehicle_licence_hint,
                    labelText: local.vehicle_licence,
                    readOnly: true,
                    controller: cubit.vehicleLicenseController,
                    suffixIcon: GestureDetector(
                      onTap: () => _pickImageForLicense(),
                      child: const Icon(Icons.file_upload_outlined),
                    ),
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: cubit.emailController,
                    hintText: local.emailHintText,
                    labelText: local.emailLabelText,
                    validator: (value) => Validators.validateNotEmpty(
                      title: local.emailLabelText,
                      value: value,
                    ),
                    keyBordType: TextInputType.text,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: cubit.phoneNumberController,
                    hintText: local.phoneHintText,
                    labelText: local.phoneLabelText,
                    validator: (value) => Validators.validatePhoneNumber(value),
                    keyBordType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: cubit.idNumberController,
                    hintText: local.id_number_hint,
                    labelText: local.id_number,
                    validator: (value) => Validators.validateNationalId(value),
                    keyBordType: TextInputType.text,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.id_image_hint,
                    labelText: local.id_image,
                    readOnly: true,
                    controller: cubit.idImageController,
                    suffixIcon: GestureDetector(
                      onTap: () => _pickImageForId(),
                      child: const Icon(Icons.file_upload_outlined),
                    ),
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: local.signupPasswordHintText,
                          labelText: local.passwordLabelText,
                          isPassword: true,
                          controller: cubit.passwordController,
                          validator: (value) =>
                              Validators.validatePassword(value),
                          keyBordType: TextInputType.text,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomTextFormField(
                          controller: cubit.confirmPasswordController,
                          hintText: local.confirmPasswordHintText,
                          labelText: local.confirmPasswordLabelText,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePasswordConfirmation(
                                  password: cubit.passwordController.text,
                                  confirmPassword: value),
                          keyBordType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: Row(
                      children: [
                        Text(
                          local.gender,
                          style: AppFonts.font18BlackWeight500,
                        ),
                        50.horizontalSpace,
                        Row(
                          children: [
                            Radio(
                              value: local.male.toLowerCase(),
                              groupValue: _gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value as String;
                                });
                              },
                            ),
                            Text(
                              local.female,
                              style: AppFonts.font14BlackWeight400,
                            ),
                            16.horizontalSpace,
                            Radio(
                              value: local.female.toLowerCase(),
                              groupValue: _gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value as String;
                                });
                              },
                            ),
                            Text(
                              local.male,
                              style: AppFonts.font14BlackWeight400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        File? vehicleLicenseFile =
                            cubit.vehicleLicenseController.text.isNotEmpty
                                ? File(cubit.vehicleLicenseController.text)
                                : null;
                        File? idImageFile =
                            cubit.idImageController.text.isNotEmpty
                                ? File(cubit.idImageController.text)
                                : null;
                        final applyData = ApplyRequestEntity(
                          country: cubit.countryController.text,
                          firstName: cubit.firstLegalNameController.text,
                          lastName: cubit.secondLegalNameController.text,
                          vehicleType: cubit.vehicleTypeController.text,
                          vehicleNumber: cubit.vehicleNumberController.text,
                          vehicleLicense: vehicleLicenseFile,
                          email: cubit.emailController.text,
                          phone: cubit.phoneNumberController.text,
                          nID: cubit.idNumberController.text,
                          nIDImg: idImageFile,
                          password: cubit.passwordController.text,
                          rePassword: cubit.confirmPasswordController.text,
                          gender: _gender,
                        );
                        cubit.apply(applyData);
                      }
                    },
                    text: local.continueText,
                  ),
                  16.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handelStateChange(ApplyState state) {
    if (state is ApplySuccess) {
      Navigator.pop(context);
      AppDialogs.showSuccessDialog(
        context: context,
        message: "Account Created Successfully.\n Please Login to proceed",
        whenAnimationFinished: () => Navigator.pushReplacementNamed(context, PageRouteName.login),
      );
    } else if (state is ApplyFail) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
          context: context, errorMassage: state.errorMassage ?? "");
    } else if (state is ApplyLoading) {
      AppDialogs.showLoading(context: context);
    }
  }

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  Future<void> _pickImageForLicense() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      setState(() {
        cubit.vehicleLicenseController.text = pickedFile.path;
      });
    } else {
      print("The license image was not selected.");
    }
  }

  Future<void> _pickImageForId() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      setState(() {
        cubit.idImageController.text = pickedFile.path;
      });
    } else {
      print("No photo ID selected.");
    }
  }

  /*************8
 *   Future<void> _pickAndUploadImage({required bool isLicense}) async {
    final pickedFile = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
    );
    if (pickedFile == null) return;
    final fileExtension = pickedFile.path.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png', 'webp'].contains(fileExtension)) {
    if (mounted) {
    AppDialogs.showErrorDialog(
    context: context,
    errorMassage: 'Only JPG, JPEG, WEBP, and PNG images are allowed.',
    );
    }
    return;
    }
    if (mounted) {
    setState(() {
    if (isLicense) {
    _licenseImage = File(pickedFile.path);
    _licenseController.text = pickedFile.name;
    applyRequestBodyModel.vehicleLicense = pickedFile.path;
    } else {
    _idImage = File(pickedFile.path);
    _idController.text = pickedFile.name;
    applyRequestBodyModel.nationalIdImage = pickedFile.path;
    }
    });
    }
    }

 */
}
