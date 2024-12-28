import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_ext.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/country_picker.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../data/model/auth/requests/sign_up_request_model.dart';
import '../../../../generated/l10n.dart';
import '../view_model/apply_view_model.dart';

class ApplyScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _countryController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  String vehicleTypeId = '';

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneNumberController;
  late String _gender;

  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _gender = '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      context.read<ApplyViewModel>().signUp(
            SignUpRequestBodyModel(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              rePassword: _confirmPasswordController.text,
              phone: _phoneNumberController.text,
              gender: _gender.toLowerCase(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return BlocListener<ApplyViewModel, SignUpState>(
      bloc: context.read<ApplyViewModel>(),
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
            local.signUpTitle,
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
                    controller: _countryController,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.firstLegalHintName,
                    labelText: local.firstLegalName,
                    validator: (value) => Validators.validateName(value),
                    keyBordType: TextInputType.text,
                    controller: _firstNameController,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.secondLegalHintName,
                    labelText: local.secondLegalName,
                    validator: (value) => Validators.validateName(value),
                    keyBordType: TextInputType.text,
                    controller: _firstNameController,
                  ),
                  24.verticalSpace,
                  CountryInputField(
                    controller: _countryController,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.vehicle_number_hint,
                    labelText: local.vehicle_number,
                    validator: (value) => Validators.validateName(value),
                    keyBordType: TextInputType.text,
                    controller: _firstNameController,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.vehicle_licence_hint,
                    labelText: local.vehicle_licence,
                    validator: (value) => Validators.validateName(value),
                    keyBordType: TextInputType.text,
                    controller: _firstNameController,
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.file_upload_outlined),
                    ),
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.emailHintText,
                    labelText: local.emailLabelText,
                    validator: (value) => Validators.validateEmail(value),
                    keyBordType: TextInputType.text,
                    controller: _emailController,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.phoneHintText,
                    labelText: local.phoneLabelText,
                    validator: (value) => Validators.validatePhoneNumber(value),
                    keyBordType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: _phoneNumberController,
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        final prefix = '+2';
                        _phoneNumberController.text = prefix;
                      }
                    },
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.id_number_hint,
                    labelText: local.id_number,
                    validator: (value) => Validators.validateName(value),
                    keyBordType: TextInputType.text,
                    controller: _firstNameController,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: local.id_image_hint,
                    labelText: local.id_image,
                    validator: (value) => Validators.validateName(value),
                    keyBordType: TextInputType.text,
                    controller: _firstNameController,
                    suffixIcon: GestureDetector(
                      onTap: () {},
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
                          validator: (value) =>
                              Validators.validatePassword(value),
                          keyBordType: TextInputType.text,
                          controller: _passwordController,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomTextFormField(
                          hintText: local.confirmPasswordHintText,
                          labelText: local.confirmPasswordLabelText,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePasswordConfirmation(
                            password: _passwordController.text,
                            confirmPassword: value,
                          ),
                          keyBordType: TextInputType.text,
                          controller: _confirmPasswordController,
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
                              value: local.female,
                              groupValue: _gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            Text(
                              local.female,
                              style: AppFonts.font14BlackWeight400,
                            ),
                            16.horizontalSpace,
                            Radio(
                              value: local.male,
                              groupValue: _gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
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
                    onPressed: signUp,
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

  void _handelStateChange(SignUpState state) {
    //   if (state is SignUpSuccess) {
    //     Navigator.pop(context);
    //     AppDialogs.showSuccessDialog(
    //       context: context,
    //       message: "Account Created Successfully.\n Please Login to proceed",
    //       whenAnimationFinished: () => Navigator.pop(context),
    //     );
    //   } else if (state is SignUpFail) {
    //     Navigator.pop(context);
    //     AppDialogs.showErrorDialog(
    //         context: context, errorMassage: state.errorMassage ?? "");
    //   } else if (state is SignUpLoading) {
    //     AppDialogs.showLoading(context: context);
    //   }
  }
}
