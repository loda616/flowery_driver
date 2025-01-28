import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view_model/profile_view_model.dart';
import 'custom_profile_pic.dart';
import 'edit_profile_form.dart';


class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({
    super.key,
    required this.driver,
    required this.gender,
    required this.onGenderChanged,
  });

  final DriverEntity? driver;
  final String? gender;
  final ValueChanged<String> onGenderChanged;

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late ProfileCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.driver != null)
            CustomProfilePic(driver: widget.driver!),
          20.verticalSpace,
          EditProfileForm(
            driver: widget.driver ?? DriverEntity(),
            gender: widget.gender,
            onGenderChanged: widget.onGenderChanged,
          ),
        ],
      ),
    );
  }
}