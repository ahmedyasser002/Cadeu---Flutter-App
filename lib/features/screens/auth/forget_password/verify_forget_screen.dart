import 'dart:developer';

import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_images.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/features/screens/auth/forget_password/forget_view_model.dart';
import 'package:demo_project/features/widgets/custom_btn.dart';
import 'package:demo_project/features/widgets/verify_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class VerifyForgetScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyForgetScreen({super.key, required this.phoneNumber});

  @override
  State<VerifyForgetScreen> createState() => _VerifyForgetScreenState();
}

class _VerifyForgetScreenState extends State<VerifyForgetScreen> {
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  String get verifyCode {
    return _controllers.map((controller) => controller.text).join();
  }

  bool canResend = false;
  double timer = 10;

  @override
  Widget build(BuildContext context) {
    log('building');
    // int time = 10;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(AppIcons.backIcon)),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(AppImages.verifyForgetImg),
                                ),
                                SizedBox(height: 12.h),
                                Center(
                                  child: Text(
                                    'Code',
                                    style:
                                        AppTextStyle.mainTitle(AppColors.black),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Center(
                                  child: Text(
                                    'We have sent the code to create\nYour account to mobile number',
                                    style: AppTextStyle.jost500(
                                        AppColors.black, 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18.h),
                                  child: Center(
                                    child: Text(
                                      widget.phoneNumber,
                                      style: AppTextStyle.jost500(
                                          AppColors.black, 22),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          return VerifyField(
                                            controller: _controllers[index],
                                            onChanged: (val) {
                                              ref
                                                  .read(ForgetViewModel.forgetNotifier)
                                                  .checkVerifyFields(verifyCode
                                                      .replaceAll(" ", "")
                                                      .length);

                                              if (val.length == 1 &&
                                                  index < 5) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                ),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final isLoading = ref.watch(ForgetViewModel.forgetNotifier
                                        .select((forgetNotifier) =>
                                            forgetNotifier.verifyCodeLoading));
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
                                    final countryCode = ref.watch(ForgetViewModel.forgetNotifier
                                        .select((forgetNotifier) =>
                                            forgetNotifier.countryCode));
                                    final phoneNo = ref.watch(ForgetViewModel.forgetNotifier
                                        .select((forgetNotifier) =>
                                            forgetNotifier.phoneNumber));
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 18.h, bottom: 24.h),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            log('pressed');
                                            timer == 0
                                                ? ref
                                                    .read(ForgetViewModel.forgetNotifier)
                                                    .setReset(true)
                                                : null;
                                            timer == 0
                                                ? _controller.restart()
                                                : null;
                                            timer == 0
                                                ? await ForgetViewModel
                                                    .getOtp(
                                                        code: countryCode,
                                                        phoneNo: phoneNo,
                                                        context: context,
                                                        screenName: "verify",
                                                        ref: ref
                                                        )
                                                : null;
                                            ref
                                                .read(ForgetViewModel.forgetNotifier)
                                                .setReset(false);
                                          },
                                          child: Text(
                                            'Resend Code',
                                            style: AppTextStyle.jost14_400(
                                                AppColors.lightGray),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Center(
                                  child: Countdown(
                                    controller: _controller,
                                    seconds: 60,
                                    build: (context, time) {
                                      timer = time;
                                      if (time == 0) {
                                        canResend = true;
                                      }
                                      if (time == 5) {
                                        log('time is 5');
                                      }
                                      return Text(
                                        '${time.toString().replaceAll(".0", "")}s',
                                        style: AppTextStyle.jost16_250(
                                            AppColors.black),
                                      );
                                    },
                                    interval: const Duration(seconds: 1),
                                    onFinished: () {
                                      log('timer is done');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final filledCode = ref.watch(ForgetViewModel.forgetNotifier
                                .select((forgetProv) => forgetProv.filledCode));
                            final code = ref.read(ForgetViewModel.forgetNotifier.select(
                                (forgetNotifier) =>
                                    forgetNotifier.countryCode));
                            final phoneNo = ref.read(ForgetViewModel.forgetNotifier.select(
                                (forgetNotifier) =>
                                    forgetNotifier.phoneNumber));
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: CustomBtn(
                                btnText: 'Next',
                                btnColor: filledCode
                                    ? AppColors.activeBtnColor
                                    : AppColors.nonActiveBtnColor,
                                onTap: filledCode
                                    ? () async {
                                        log(verifyCode);
                                        await ForgetViewModel.checkOtp(
                                            input: verifyCode,
                                            countryCode: code,
                                            phoneNo: phoneNo,
                                            context: context,
                                            ref: ref
                                            );
                                      }
                                    : () {},
                              ),
                            );
                          },
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
















