import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_images.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/features/screens/auth/forget_password/forget_view_model.dart';
import 'package:demo_project/features/widgets/custom_btn.dart';
import 'package:demo_project/features/widgets/custom_country_picker.dart';
import 'package:demo_project/features/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ForgetPassScreen extends StatelessWidget {
  ForgetPassScreen({super.key});
  String code = '';
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(right: 12.w, left: 12.w, top: 18.h),
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
              Center(child: Image.asset(AppImages.lockImg)),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Forget Password',
                  style: AppTextStyle.mainTitle(AppColors.black),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Enter phone number to reveive\ncode on it',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.jost12_400(AppColors.subGray),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 54.h,
                ),
                child: Text(
                  'Phone number',
                  style: AppTextStyle.jost500(AppColors.black50, 12.sp),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomCountryPicker(onSelect: (phoneCode) {
                    code = phoneCode;
                  }),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(child: Consumer(builder: (context, ref, child) {
                    return CustomTextfield(
                      hintText: 'EX : 01214182021',
                      labelText: '',
                      fieldController: phoneController,
                      onChanged: (value) {
                        ref.read(ForgetViewModel.forgetNotifier.select((forgetViewModel) =>
                            forgetViewModel
                                .setField(value.length >= 3 ? true : false)));
                      },
                    );
                  }))
                ],
              ),
              Consumer(builder: (context, ref, child) {
                final isLoading = ref.watch(ForgetViewModel.forgetNotifier.select(
                    (forgetNotifier) => forgetNotifier.forgetPassLoading));
                return isLoading ?Padding(
                  padding:  EdgeInsets.only(top: 12.h),
                  child: const Center(child: CircularProgressIndicator()),
                ) : const SizedBox();
              }),
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: Consumer(
                  builder: (context, ref, child) {
                    final isFilled = ref.watch(ForgetViewModel.forgetNotifier.select(
                        (forgetViewModel) => forgetViewModel.filledFields));
                    return CustomBtn(
                        btnText: 'Next',
                        btnColor: isFilled
                            ? AppColors.activeBtnColor
                            : AppColors.nonActiveBtnColor,
                        onTap: isFilled
                            ? () async {
                                FocusScope.of(context).unfocus();
                                ref.read(ForgetViewModel.forgetNotifier).setPhone_CountryCode(
                                    phone: phoneController.text, code: code);
                                await ForgetViewModel.getOtp(
                                    context: context,
                                    code: code,
                                    phoneNo: phoneController.text,
                                    ref: ref
                                    );
                              }
                            : () {});
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
