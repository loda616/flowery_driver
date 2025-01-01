import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_ext.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../view_model/login_cubit.dart';
import '../view_model/login_state.dart';

class LogInScreen extends StatefulWidget {
  static String routeName = "login page";

  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late final LoginViewModel viewModel;

  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isRememberMe = false;

  @override
  void initState() {
    viewModel = context.read<LoginViewModel>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocProvider<LoginViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          leadingWidth: 40.w,
          title: Text(
            local.loginTitle,
            style: AppFonts.font20BlackWeight500,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  24.verticalSpace,
                  BlocListener<LoginViewModel, LoginScreenState>(
                    listener: (context, state) {
                      switch (state) {
                        case LoadingState():
                          {
                            AppDialogs.showLoading(context: context);
                          }
                        case ErrorState():
                          {
                            AppDialogs.showHideDialog(context);
                            AppDialogs.showErrorDialog(
                              context: context,
                              errorMassage: state.message ?? "",
                            );
                          }
                        case SuccessState():
                          {
                            Navigator.of(context).pop();
                            AppDialogs.showSuccessDialog(
                              context: context,
                              message: local.userLoggedInSuccessfully,
                              whenAnimationFinished: () {
                                // Navigator.pushReplacementNamed(
                                //     context, PageRouteName.homeLayout);
                              },
                            );
                          }
                        default:
                          {}
                      }
                    },
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: (local.emailHintText),
                          labelText: (local.emailLabelText),
                          controller: _emailController,
                          keyBordType: TextInputType.text,
                          validator: (value) => Validators.validateEmail(value),
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          hintText: (local
                              .passwordHintText), //AppStrings.passwordHintText,
                          labelText: (local.passwordLabelText),
                          controller: _passwordController,
                          keyBordType: TextInputType.text,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePassword(value),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors.kPink;
                                }
                                return AppColors.kWhite;
                              }),
                              value: _isRememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _isRememberMe = value!;
                                });
                              },
                            ),
                            Text((local.rememberMeText),
                                style: AppFonts.font13BlackWeight400),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRouteName.forgetPassword);
                              },
                              child: Text(
                                (S.of(context).forgetPasswordText),
                                style: AppFonts
                                    .font12BlackWeight400UnderlinedBlack,
                              ),
                            ),
                          ],
                        ),
                        250.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              viewModel.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                                rememberMe: _isRememberMe,
                              );
                            }
                          },
                          color: AppColors.kPink,
                          text: (local.continueText),
                          textStyle: AppFonts.font16LightWhiteWeight500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
