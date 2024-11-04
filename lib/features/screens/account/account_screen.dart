import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/features/screens/account/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 12.h, top: 12.h),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(AccountViewModel.accountNotifier.select((accNotifier)=>accNotifier.logOutLoading)) ? Padding(
                  padding: EdgeInsets.only(bottom: 48.h),
                  child: const CircularProgressIndicator(),
                ) : const SizedBox();
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () async {
                    AccountViewModel.logout(context, ref);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
                    decoration: BoxDecoration(
                        color: const Color(0xFFEFF3F5),
                        border: Border.all(
                            color: AppColors.grayBorder, width: 1.sp)),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.logout),
                        SizedBox(width: 10.w),
                        Text(
                          'Log Out',
                          style: AppTextStyle.jost500(AppColors.black, 14),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
