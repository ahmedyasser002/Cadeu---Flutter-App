import 'package:demo_project/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBtn extends StatelessWidget {
  final String btnText;
  final Color btnColor;
  final void Function() onTap;
  const CustomBtn({super.key, required this.btnText, required this.btnColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        // send color from parent widget
        color: btnColor,
        child: Center(
          child: Text(
            btnText,
            style: AppTextStyle.btnText,
          ),
        ),
      ),
    );
  }
}
