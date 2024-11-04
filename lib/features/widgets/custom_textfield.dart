import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController fieldController;
  final void Function(String value)? onChanged;
  final String? suffixIcon;
  final void Function()? onSuffixTap;
  final bool? isObsecure;

  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.fieldController,
      this.onChanged,
      this.suffixIcon,
      this.onSuffixTap,
      this.isObsecure
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscuringCharacter: '*',
      obscureText: isObsecure==true ? true : false,
      onChanged: onChanged,
      controller: fieldController,
      decoration: InputDecoration(
        
        suffixIconConstraints: BoxConstraints(
            maxWidth: 28.w, maxHeight: 28.h, minHeight: 28.h, minWidth: 28.w),
        suffixIcon: InkWell(
            onTap: onSuffixTap,
            child: suffixIcon != null ? ( isObsecure! ? SvgPicture.asset(suffixIcon!) : const Icon(Icons.visibility) ): null),
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: AppTextStyle.hintText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: AppColors.black50),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: AppColors.black50),
        ),
      ),
    );
  }
}
