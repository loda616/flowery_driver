import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../view_model/forget_passwoed_cubit.dart';
import 'pin_code_file.dart';

class EmailVerificationWidget extends StatelessWidget {
  final ForgetPasswordCubit viewModel;

  const EmailVerificationWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.arrow_back_ios_outlined),
              SizedBox(
                width: 10.w,
              ),
              Text(
                locale.forgetPasswordScreenTitle,
                style: AppFonts.font20BlackWeight400,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(locale.emailVerificationScreenTitle,
              style: AppFonts.font18BlackWeight500),
          SizedBox(
            height: 10.h,
          ),
          Text(
            locale.emailVerificationScreenDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          PinCodeFile(
            onCodeCompleted: (resetCode) {
              viewModel.verifyResetCode(resetCode: resetCode);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locale.didnotReceiveCode,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: viewModel.isResendButtonEnabled,
                builder: (context, isEnabled, child) {
                  return InkWell(
                    onTap: isEnabled
                        ? () {
                            viewModel.resendResetCode();
                          }
                        : null,
                    child: ValueListenableBuilder<String?>(
                      valueListenable: viewModel.resendButtonText,
                      builder: (context, value, child) {
                        return Text(
                          value ?? " Resend",
                          style: isEnabled
                              ? AppFonts.font16PinkWeight400UnderlinedPink
                              : AppFonts.font16PinkWeight400UnderlinedPink,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
