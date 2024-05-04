import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practical_assessment_app/res/app_colors.dart';
import 'package:practical_assessment_app/res/components/custom_rectangle_button.dart';
import 'package:practical_assessment_app/res/components/custom_textfield.dart';
import 'package:practical_assessment_app/utils/routes/routes_name.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/utils/utils.dart';
import 'package:practical_assessment_app/viewModel/auth_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();

  ValueNotifier<bool> isTermedChecked = ValueNotifier<bool>(false);

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Text(
                "Hi, Welcome!👋",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 30,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 40,
              ),
              Text(
                "Give us your",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "mobile number",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 90,
              ),
              Text(
                "to Log in, we need your mobile number",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 55,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 90,
              ),
              CustomTextField(
                textFieldController: phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 50,
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(9),
              //   child: RoundCheckBox(
              //     onTap: (value) {},
              //     isChecked: true,
              //     border: Border.all(
              //       width: 1,
              //     ),
              //     isRound: false,
              //     checkedColor: AppColors.checkboxColor,
              //     size: ScreenConfig.screenWidth / 25,
              //   ),
              // ),
              ValueListenableBuilder(
                valueListenable: isTermedChecked,
                builder: (context, value, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: RoundCheckBox(
                      onTap: (val) {
                        isTermedChecked.value = val!;
                        log(isTermedChecked.value.toString());
                      },
                      isChecked: value,
                      border: Border.all(
                        width: 1,
                      ),
                      isRound: false,
                      checkedColor: AppColors.checkboxColor,
                      size: ScreenConfig.screenWidth / 25,
                    ),
                  );
                },
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 50,
              ),
              RichText(
                text: TextSpan(
                    text: "I have read and agreed to the ",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: -0.2,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text: "Terms and Conditions*",
                          style: TextStyle(color: AppColors.checkboxColor))
                    ]),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 20,
              ),
              CustomRectangleButton(
                  loading: authViewModel.loading,
                  title: "Send OTP",
                  onClick: () {
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(patttern);
                    if (phoneController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Please enter phone Number", context);
                    } else if (!regExp.hasMatch(phoneController.text)) {
                      Utils.flushBarErrorMessage(
                          "Please enter 10 digit phone Number", context);
                    } else if (isTermedChecked.value == false) {
                      Utils.flushBarErrorMessage(
                          "Please check Terms and Conditions*", context);
                    } else {
                      AuthViewModel.sendOTP(phoneController.text, context);
                    }

                    // Navigator.pushNamed(context, RoutesName.otpScreen);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
