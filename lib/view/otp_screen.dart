import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:practical_assessment_app/res/app_colors.dart';
import 'package:practical_assessment_app/res/components/custom_rectangle_button.dart';
import 'package:practical_assessment_app/utils/routes/routes_name.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/utils/utils.dart';
import 'package:practical_assessment_app/viewModel/auth_viewModel.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final firebaseVerificationId;
  const OtpScreen({super.key, required this.firebaseVerificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color(0xffD8DADC);
    const fillColor = AppColors.white;
    const borderColor = Color(0xffD8DADC);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConfig.screenWidth / 40,
              vertical: ScreenConfig.screenWidth / 30),
          width: ScreenConfig.screenWidth,
          height: ScreenConfig.screenHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/farmer_home.png"),
                  alignment: AlignmentDirectional.bottomCenter,
                  fit: BoxFit.fitWidth)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade400))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              SizedBox(
                height: ScreenConfig.screenHeight / 40,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 90,
              ),
              Text(
                "Enter the verification code that we have just sent on your phone number",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 55,
                    color: Color(0xff8C8E8F),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 20,
              ),
              Pinput(
                controller: pinController,
                focusNode: focusNode,
                length: 6,
                // androidSmsAutofillMethod:
                //     AndroidSmsAutofillMethod.smsUserConsentApi,
                // listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                // validator: (value) {
                //   // return value == '2222' ? null : 'Pin is incorrect';
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  print('============>>>>>>>>>>>>>>> onCompleted: $pin');
                  // signIn();
                },
                onChanged: (value) {
                  // print('============>>>>>>>>>>>>>>> onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  textStyle: TextStyle(
                      fontSize: ScreenConfig.screenWidth / 30,
                      // letterSpacing: -0.5,
                      fontWeight: FontWeight.bold),
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyWith(
                  textStyle: TextStyle(
                      fontSize: ScreenConfig.screenWidth / 30,
                      // letterSpacing: -0.5,
                      fontWeight: FontWeight.bold),
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 10,
              ),
              CustomRectangleButton(
                  loading: authViewModel.loading,
                  title: "Verify",
                  onClick: () {
                    if (pinController.text.length == 6) {
                      log("verify clicked");
                      AuthViewModel.verifyOTP(widget.firebaseVerificationId,
                          pinController.text, context);
                    } else {
                      Utils.flushBarErrorMessage(
                          "Please enter 6 digit OTP", context);
                    }

                    // Navigator.pushNamed(context, RoutesName.userNameScreen);
                  }),
              SizedBox(
                height: ScreenConfig.screenHeight / 35,
              ),
              const Center(
                child: Text(
                  "Resend OTP in 29s",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 50,
              ),
              const Center(
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xffB6B6B6),
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
