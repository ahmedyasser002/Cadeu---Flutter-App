import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopOfferItem extends StatelessWidget {
  const TopOfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 1.sp, color: AppColors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.discountIcon),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top offer for Birthday',
                style: AppTextStyle.jost700(AppColors.black, 14),
              ),
              SizedBox(height: 5.h),
              Text(
                'Discover top offers for birthday\'s gift and save money',
                style: AppTextStyle.jost10_400(AppColors.black),
              )
            ],
          ),
          const Spacer(),
          SvgPicture.asset(AppIcons.forwardIcon)
        ],
      ),
    );
  }
}
