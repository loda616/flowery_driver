import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitchTitle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final TextStyle? titleStyle;
  final String title;

  const CustomSwitchTitle({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.white,
    required this.activeTrackColor ,
    this.inactiveThumbColor = Colors.white,
    this.inactiveTrackColor = Colors.grey,
    this.titleStyle,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
   // final local = S.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          // Switch widget
          Transform.scale(
            scale: 0.8.w,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title
           // local.notification,
           // style: AppFonts.font13BlackWeight400,
          ),
        ],
      ),
    );
  }
}
