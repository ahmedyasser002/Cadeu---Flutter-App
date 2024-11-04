import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_images.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/features/screens/auth/forget_password/forget_view_model.dart';
import 'package:demo_project/features/widgets/custom_btn.dart';
import 'package:demo_project/features/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class SetNewPassScreen extends StatelessWidget {
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  SetNewPassScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.only(right: 12.w, left: 12.w, top: 18.h, bottom: 18.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(AppIcons.backIcon)),
              SizedBox(height: 48.h),
              Center(
                child: Image.asset(AppImages.lockImg),
              ),
              SizedBox(height: 20.h),
              Center(
                  child: Text('Set New Password',
                      style: AppTextStyle.mainTitle(AppColors.black))),
              Padding(
                padding: EdgeInsets.only(top: 42.h, bottom: 2.h),
                child: Text(
                  'New Password',
                  style: AppTextStyle.jost500(AppColors.black50, 12),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final isObsecure = ref.watch(ForgetViewModel.forgetNotifier
                      .select((forgetNotifier) => forgetNotifier.isObsecure));
                  return CustomTextfield(
                    hintText: 'Enter at least 8 characters',
                    fieldController: newPassController,
                    labelText: '',
                    suffixIcon: AppIcons.obsecureIcon,
                    isObsecure: isObsecure,
                    onSuffixTap: () =>
                        ref.read(ForgetViewModel.forgetNotifier).toggleObsecure(),
                    onChanged: (value) {
                      ref.read(ForgetViewModel.forgetNotifier).checkNewPassword(
                          newPass: newPassController.text,
                          confirmPass: confirmPassController.text);
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Your Password Must have',
                style: AppTextStyle.jost500(AppColors.black, 12),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final verifiedLength = ref.watch(ForgetViewModel.forgetNotifier.select(
                      (forgetNotifier) => forgetNotifier.verifiedLength));
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            verifiedLength
                                ? AppIcons.enabledTrue
                                : AppIcons.disabledTrue,
                            width: 14.61.w,
                            height: 14.61.h),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          '8 to 20 Character',
                          style: AppTextStyle.jost12_400(verifiedLength
                              ? AppColors.black
                              : AppColors.subGray),
                        )
                      ],
                    ),
                  );
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final verifiedRegex = ref.watch(ForgetViewModel.forgetNotifier.select(
                      (forgetNotifier) => forgetNotifier.verifiedRegex));
                  return Row(
                    children: [
                      SvgPicture.asset(
                        verifiedRegex
                            ? AppIcons.enabledTrue
                            : AppIcons.disabledTrue,
                        width: 14.61.w,
                        height: 14.61.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        'Letters , numbers and special characters',
                        style: AppTextStyle.jost12_400(verifiedRegex
                            ? AppColors.black
                            : AppColors.subGray),
                      )
                    ],
                  );
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Confirm Password',
                style: AppTextStyle.jost500(AppColors.black50, 12),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final isObsecure2 = ref.watch(ForgetViewModel.forgetNotifier
                      .select((forgetNotifier) => forgetNotifier.isObsecure2));
                  return CustomTextfield(
                    hintText: 'Enter at least 8 characters',
                    fieldController: confirmPassController,
                    labelText: '',
                    suffixIcon: AppIcons.obsecureIcon,
                    isObsecure: isObsecure2,
                    onSuffixTap: () =>
                        ref.read(ForgetViewModel.forgetNotifier).toggleObsecure2(),
                    onChanged: (value) {
                      ref.read(ForgetViewModel.forgetNotifier).checkNewPassword(
                          newPass: newPassController.text,
                          confirmPass: confirmPassController.text);
                    },
                  );
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final isLoading = ref.watch(ForgetViewModel.forgetNotifier.select(
                      (forgetNotifier) => forgetNotifier.setNewPassLoading));
                  return isLoading ? Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ) : const SizedBox();
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final isActiveBtn = ref.watch(ForgetViewModel.forgetNotifier
                      .select((forgetNotifier) => forgetNotifier.setNewBtn));
                  final countryCode = ref.watch(ForgetViewModel.forgetNotifier
                      .select((forgetNotifier) => forgetNotifier.countryCode));
                  final phoneNo = ref.watch(ForgetViewModel.forgetNotifier
                      .select((forgetNotifier) => forgetNotifier.phoneNumber));
                  final token = ref.watch(ForgetViewModel.forgetNotifier
                      .select((forgetNotifier) => forgetNotifier.token));

                  return Padding(
                    padding: EdgeInsets.only(top: 48.h),
                    child: CustomBtn(
                        btnText: 'Next',
                        btnColor: isActiveBtn
                            ? AppColors.activeBtnColor
                            : AppColors.nonActiveBtnColor,
                        onTap: isActiveBtn
                            ? () async {
                                await ForgetViewModel.setNewPassword(
                                    countryCode: countryCode,
                                    phoneNo: phoneNo,
                                    token: token,
                                    password: newPassController.text,
                                    confirmPassword: confirmPassController.text,
                                    context: context,
                                    ref: ref
                                    );
                              }
                            : () {}),
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
