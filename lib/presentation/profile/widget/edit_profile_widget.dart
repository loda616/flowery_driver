import 'package:flowery_driver/data/model/profile/profile_response/driver_model.dart';
import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_profile_pic.dart';
import 'edit_driver_Info_form.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({
    super.key,
    required this.driver,
    required this.gender,
    required this.onGenderChanged,
  });
  final DriverEntity driver;
  final String? gender;
  final ValueChanged<String> onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomProfilePic(driver: driver),
          20.verticalSpace,
          EditDriverInfoForm(
            driver: driver,
            gender: gender,
            onGenderChanged: onGenderChanged,
          ),
        ],
      ),
    );
  }
}
