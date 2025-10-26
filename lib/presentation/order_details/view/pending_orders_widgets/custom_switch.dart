import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final TextStyle? titleStyle;
  final String title;

  const CustomSwitch(
      {super.key,
        required this.value,
        required this.onChanged,
        this.activeColor = Colors.white,
        required this.activeTrackColor,
        this.inactiveThumbColor = Colors.white,
        this.inactiveTrackColor = Colors.grey,
        this.titleStyle,
        required this.title});

  @override
  Widget build(BuildContext context) {
    // final local = S.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          // Switch widget
          Text(title,style: titleStyle,),
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
        ],
      ),
    );
  }
}
