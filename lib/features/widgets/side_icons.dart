import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideIcons extends StatelessWidget {
  final String iconName;
  const SideIcons({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 24.h,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Center(
        child: SvgPicture.asset(iconName),
      ),
    );
  }
}
