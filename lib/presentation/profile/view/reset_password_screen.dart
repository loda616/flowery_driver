import 'package:flowery_driver/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            CustomTextFormField(
              hintText: local.currentPassword,
              labelText: local.currentPassword,
              controller: currentPasswordController,
              keyBordType: TextInputType.text,
              isPassword: true,
              validator: (value) => Validators.validatePassword(value),
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              hintText: local.newPassword,
              labelText: local.newPasswordLabelText,
              controller: newPasswordController,
              keyBordType: TextInputType.text,
              isPassword: true,
              validator: (value) => Validators.validatePassword(value),
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              hintText: local.confirmPasswordHintText,
              labelText: local.confirmPasswordLabelText,
              controller: confirmPasswordController,
              keyBordType: TextInputType.text,
              isPassword: true,
              validator: (value) => Validators.validatePasswordConfirmation(
                  password: newPasswordController.text, confirmPassword: value),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _resetPassword();
                  }
                },
                color: AppColors.kGray,
                text: local.updateText,
                textStyle: AppFonts.font16BlackWeight500,
              ),
            ),
            if (_isLoading) Center(child: CircularProgressIndicator()),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    bool isSuccess = true;

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: "Password Changed Successfully",
        whenAnimationFinished: () => Navigator.pop(context),
      );
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = "Failed to reset password. Please try again.";
      });
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: _errorMessage ?? "",
      );
    }
  }
}
