import 'package:country_code_picker/country_code_picker.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCountryPicker extends StatelessWidget {
    final void Function(String phoneNo) onSelect;

  const CustomCountryPicker({super.key , required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (value) {
        onSelect(value.dialCode!);
      },
      onInit: (value) {
        onSelect(value!.dialCode!);
      },
      initialSelection: 'EG',
      showFlag: false,
      showFlagMain: false,
      builder: (code) {
        return Container(
          width: 49.w,
          padding: EdgeInsets.only(
            bottom: 12.h
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.88,
                color: Colors.black
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                code!.dialCode!,
              ),
              SvgPicture.asset(AppIcons.downIcon)
            ],
          ),
        );
      },
    );
  }
}
