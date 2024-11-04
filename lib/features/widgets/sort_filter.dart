import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SortFilter extends StatelessWidget {
  const SortFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      width: 180.w,
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1.sp,
          color: AppColors.black,
        ),
        borderRadius: BorderRadius.all(Radius.circular(25.r)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.sortIcon),
          SizedBox(
            width: 8.w,
          ),
          Text(
            'Sort by',
            style: AppTextStyle.jost500(AppColors.black, 14),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Container(
              width: 1.w,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.sp, color: AppColors.black)),
            ),
          ),
          const Spacer(),
          SvgPicture.asset(AppIcons.filterIcon),
          SizedBox(
            width: 8.w,
          ),
          Text(
            'Filter by',
            style: AppTextStyle.jost500(AppColors.black, 14),
          )
        ],
      ),
    );
  }
}
