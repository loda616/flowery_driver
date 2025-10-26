import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../core/di/di.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../generated/l10n.dart';
import '../view_model/profile_states.dart';
import '../view_model/profile_view_model.dart';
import '../widget/edit_profile_widget.dart';

class EditDriverInfoScreen extends StatefulWidget {
  static const String routeName = 'ProfileScreen';

  const EditDriverInfoScreen({super.key});

  @override
  State<EditDriverInfoScreen> createState() => _EditDriverInfoScreenState();
}

class _EditDriverInfoScreenState extends State<EditDriverInfoScreen> {
  late ProfileCubit viewModel;
  String? gender;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getLoggedUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(local.editProfile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is GetLoggedDriverInfoLoadingState) {
            return _buildLoading();
          } else if (state is GetLoggedDriverInfoErrorState) {
            return _buildError(state.errorMessage ?? local.anErrorOccurred);
          } else if (state is GetLoggedDriverInfoSuccessState) {
            print("object ${state.driver?.gender}");
            return SingleChildScrollView(
              child: Column(
                children: [
                  EditProfileWidget(
                    driver: state.driver!,
                    gender: state.driver?.gender,
                    onGenderChanged: _onGenderChanged,
                  )
                ],
              ),
            );
          } else if (state is EditProfileLoadingState) {
            return _buildLoading();
          } else if (state is EditProfileSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppDialogs.showSuccessDialog(
                context: context,
                message: local.profileUpdatedSuccessfully,
                whenAnimationFinished: () => Navigator.pop(context),
              );
            });
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Lottie.asset(AppImages.pinkLoadingAnimation),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(message),
    );
  }

  void _onGenderChanged(String newGender) {
    setState(() {
      gender = newGender;
      hasChanges = true;
    });
  }
}

