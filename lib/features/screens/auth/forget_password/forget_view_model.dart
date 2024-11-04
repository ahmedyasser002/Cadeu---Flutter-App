import 'dart:async';
import 'dart:developer';
import 'package:demo_project/data/repos/auth/forget_pass_repo.dart';
import 'package:demo_project/features/screens/auth/forget_password/set_new_pass_screen.dart';
import 'package:demo_project/features/screens/auth/forget_password/verify_forget_screen.dart';
import 'package:demo_project/features/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetViewModel {
  static final forgetNotifier =
      ChangeNotifierProvider((ref) => ForgetNotifier());
  static final ForgetPassRepository _forgetPassRepository =
      ForgetPassRepository();
  static Future getOtp({
    required String code,
    required String phoneNo,
    required BuildContext context,
    required WidgetRef ref,
    String? screenName,
  }) async {
    ref.read(forgetNotifier).toggleForgetPassLoading(true);
    final response = await _forgetPassRepository.getOtp(code, phoneNo);
    ref.read(forgetNotifier).toggleForgetPassLoading(false);
    // log(otpCode);
    if (response != 'error') {
      ref.read(forgetNotifier).setOtpCode(response);
      screenName != "verify"
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyForgetScreen(
                        phoneNumber: '$code$phoneNo',
                      )))
          : null;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Incorrect phone')));
    }
  }

  static Future checkOtp({
    required String input,
    required String countryCode,
    required String phoneNo,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    ref.read(forgetNotifier).toggleVerifyLoading(true);
    final response = await _forgetPassRepository.checkOtp(
        input: input, countryCode: countryCode, phoneNo: phoneNo);
    ref.read(forgetNotifier).toggleVerifyLoading(false);
    log('resonse is $response');
    if (response != 'error') {
      ref.read(forgetNotifier).setToken(response);
      log('token is ${ref.read(forgetNotifier).token}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SetNewPassScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Wrong OTP')));
    }
  }

  static Future setNewPassword(
      {required String countryCode,
      required String phoneNo,
      required String token,
      required String password,
      required String confirmPassword,
      required WidgetRef ref,
      required BuildContext context}) async {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password and Confirm Password does not match")));
    } else {
      ref.read(forgetNotifier).toggleSetNewsPassLoading(true);
      final response = await _forgetPassRepository.setNewPass(
          countryCode: countryCode,
          phoneNo: phoneNo,
          token:token,
          password: password,
          confirmPassword: confirmPassword);
      ref.read(forgetNotifier).toggleSetNewsPassLoading(false);
      if (response != 'error') {
        Navigator.of(context).popUntil((route) {
          return route.isFirst;
        });
        // Rebuild the login screen by pushing it again
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }
}

class ForgetNotifier extends ChangeNotifier {
  bool filledFields = false;
  bool filledCode = false;
  int timerCounter = 60;
  bool canReset = false;
  bool isValidCode = false;
  String otpCode = '';
  Timer? timer;
  bool setNewBtn = false;
  bool isObsecure = true;
  bool isObsecure2 = true;
  bool verifiedLength = false;
  bool verifiedRegex = false;
  String countryCode = '';
  String phoneNumber = '';
  String token = '';
  bool forgetPassLoading = false;
  bool verifyCodeLoading = false;
  bool setNewPassLoading = false;
  void toggleForgetPassLoading(bool val) {
    forgetPassLoading = val;
    notifyListeners();
  }

  void setField(bool value) {
    filledFields = value;
    notifyListeners();
  }

  void setPhone_CountryCode({required String phone, required String code}) {
    phoneNumber = phone;
    countryCode = code;
  }

  // verification code

  void checkVerifyFields(int noFilled) {
    if (noFilled == 6) {
      filledCode = true;
    } else {
      filledCode = false;
    }
    notifyListeners();
  }

  void startTimer() {
    // Cancel any existing timer
    timer?.cancel();

    timerCounter = 60; // Reset to initial value
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timerCounter > 0) {
        timerCounter -= 1;
        notifyListeners();
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
    timerCounter = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void setReset(bool val) {
    canReset = val;
    notifyListeners();
  }

  void setOtpCode(String code) {
    otpCode = code;
  }

  void toggleVerifyLoading(bool val) {
    verifyCodeLoading = val;
    notifyListeners();
  }
  // Future getOtp(
  //     {required String code,
  //     required String phoneNo,
  //     required BuildContext context,
  //     String? screenName}) async {
  //   forgetPassLoading = true;
  //   notifyListeners();
  //   final response = await _forgetPassRepository.getOtp(code, phoneNo);
  //   forgetPassLoading = false;
  //   notifyListeners();
  //   // log(otpCode);
  //   if (response != 'error') {
  //     otpCode = response;
  //     screenName != "verify"
  //         ? Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => VerifyForgetScreen(
  //                       phoneNumber: '$code$phoneNo',
  //                     )))
  //         : null;
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Incorrect phone')));
  //   }
  // }

  // Future checkOtp(
  //     {required String input,
  //     required String countryCode,
  //     required String phoneNo,
  //     required BuildContext context}) async {
  //   verifyCodeLoading = true;
  //   notifyListeners();
  //   final response = await _forgetPassRepository.checkOtp(
  //       input: input, countryCode: countryCode, phoneNo: phoneNo);
  //   verifyCodeLoading = false;
  //   notifyListeners();
  //   log('resonse is $response');
  //   if (response != 'error') {
  //     token = response;
  //     log('token is $token');
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SetNewPassScreen()));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Wrong OTP')));
  //   }
  // }
  void setToken(String tkn) {
    token = tkn;
  }

// set new password
  void checkNewPassword(
      {required String newPass, required String confirmPass}) {
    bool containsAll(String input) {
      final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(input);
      final hasNumbers = RegExp(r'\d').hasMatch(input);
      final hasSpecialCharacters =
          RegExp(r'[!@#$%^&*(),.?":{}|<>_]').hasMatch(input);

      return hasLetters && hasNumbers && hasSpecialCharacters;
    }

    // the first if condition to avoid unnecessary ui updates when no one of condition happens
    if (newPass.length >= 8 ||
        newPass.length <= 20 ||
        containsAll(newPass) ||
        confirmPass.length >= 8) {
      if (newPass.length >= 8 && newPass.length <= 20) {
        verifiedLength = true;
      } else {
        verifiedLength = false;
      }
      if (containsAll(newPass)) {
        verifiedRegex = true;
      } else {
        verifiedRegex = false;
      }
      if (confirmPass.length >= 8 && newPass.length >= 8) {
        setNewBtn = true;
      } else {
        setNewBtn = false;
      }
      notifyListeners();
    }
  }

  void toggleObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  void toggleObsecure2() {
    isObsecure2 = !isObsecure2;
    notifyListeners();
  }

  void toggleSetNewsPassLoading(bool val) {
    setNewPassLoading = val;
    notifyListeners();
  }
  // Future setNewPassword(
  //     {required String countryCode,
  //     required String phoneNo,
  //     required String token,
  //     required String password,
  //     required String confirmPassword,
  //     required BuildContext context}) async {
  //   if (password != confirmPassword) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("Password and Confirm Password does not match")));
  //   } else {
  //     setNewPassLoading = true;
  //     notifyListeners();
  //     final response = await _forgetPassRepository.setNewPass(
  //         countryCode: countryCode,
  //         phoneNo: phoneNo,
  //         token: token,
  //         password: password,
  //         confirmPassword: confirmPassword);
  //     setNewPassLoading = false;
  //     notifyListeners();
  //     if (response != 'error') {
  //       Navigator.of(context).popUntil((route) {
  //         return route.isFirst;
  //       });
  //       // Rebuild the login screen by pushing it again
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //       );
  //     }
  //   }
  // }
}
