import 'dart:developer';
import 'dart:io';

import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_images.dart';
import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/data/models/user_model.dart';
import 'package:demo_project/features/screens/auth/forget_password/forget_pass_screen.dart';
import 'package:demo_project/features/screens/auth/login/login_view_model.dart';
import 'package:demo_project/features/widgets/custom_btn.dart';
import 'package:demo_project/features/widgets/custom_textfield.dart';
import 'package:demo_project/features/widgets/custom_country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
// Consumer stateful
class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String code = '';

  bool isActive = false;
  bool isObsecure = true;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String removePlus(String code) {
    return code.replaceAll('+', '');
  }

  @override
  Widget build(BuildContext context) {
    log(LocalStorageHelper.getStrings(AppKeys.tokenKey));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(left: 12.h, right: 12.h, top: 18.h, bottom: 24.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AppIcons.backIcon),
                        SizedBox(height: 54.h),
                        Center(
                          child: Image.asset(AppImages.loginLogo),
                        ),
                        SizedBox(height: 24.h),
                        Center(
                          child: Text('Welcome back',
                              style: AppTextStyle.mainTitle(AppColors.black)),
                        ),
                        Center(
                          child: Text('log in',
                              style: AppTextStyle.mainTitle(AppColors.gray)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.h, bottom: 2.h),
                          child: Text('Phone number',
                              style: AppTextStyle.textfieldTitle),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomCountryPicker(
                              onSelect: (phoneNo) {
                                code = phoneNo;
                                log(code);
                              },
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: CustomTextfield(
                                fieldController: phoneController,
                                hintText: '0124949',
                                labelText: '',
                                onChanged: (value) {
                                  ref.read(LoginViewModel.loginNotifier).checkFilledField(
                                      phoneController.text.length,
                                      passController.text.length);
                                },
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Text('Password',
                              style: AppTextStyle.textfieldTitle),
                        ),
                        Consumer(
                          builder: (context, value, child) {
                            final isObsecure = ref.watch(LoginViewModel.loginNotifier.select(
                                (loginNotifier) => loginNotifier.isObsecure));
                            return CustomTextfield(
                              hintText: 'Enter Your Password Here',
                              fieldController: passController,
                              labelText: '',
                              suffixIcon: AppIcons.obsecureIcon,
                              isObsecure: isObsecure,
                              onSuffixTap: () =>
                                  ref.read(LoginViewModel.loginNotifier).toggleObsecure(),
                              onChanged: (value) {
                                ref.read(LoginViewModel.loginNotifier).checkFilledField(
                                    phoneController.text.length,
                                    passController.text.length);
                              },
                            );
                          },
                        ),
                        SizedBox(height: 32.h),
                        Consumer(builder: (context, value, child) {
                          final isActive = ref.watch(LoginViewModel.loginNotifier.select(
                              (loginNotifier) => loginNotifier.isActive));
                          return CustomBtn(
                            btnText: 'Next',
                            btnColor: isActive
                                ? AppColors.activeBtnColor
                                : AppColors.nonActiveBtnColor,
                            onTap: isActive
                                ? () {
                                    FocusScope.of(context).unfocus();
                                    LoginViewModel.loginUser(
                                        User(
                                            countryCode: code,
                                            password: passController.text,
                                            phoneNumber: phoneController.text),
                                        Platform.operatingSystem,
                                        context,
                                        ref);
                                  }
                                : () {},
                          );
                        }),
                        Consumer(builder: (context, value, child) {
                          final isLoading = ref.watch(LoginViewModel.loginNotifier.select((loginNotifier)=>loginNotifier.isLoading));
                          log('$isLoading');
                          return isLoading
                              ? Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: const Center(
                                      child: CircularProgressIndicator()))
                              : const SizedBox();
                        }),
                        SizedBox(height: 18.h),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forget Password ?',
                                style: AppTextStyle.jost500(
                                    AppColors.black, 12.sp),
                              )
                            ],
                          ),
                        ),
                        Flexible(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You don\'t have account ? ',
                              style:
                                  AppTextStyle.jost500(AppColors.black, 14.sp),
                            ),
                            Text(
                              'Sign up',
                              style:
                                  AppTextStyle.jost500(AppColors.orange, 14.sp),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
