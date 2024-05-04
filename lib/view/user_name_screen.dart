import 'package:flutter/material.dart';
import 'package:practical_assessment_app/res/components/custom_rectangle_button.dart';
import 'package:practical_assessment_app/res/components/custom_textfield.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/utils/utils.dart';
import 'package:practical_assessment_app/viewModel/auth_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userNameScreen extends StatefulWidget {
  const userNameScreen({super.key});

  @override
  State<userNameScreen> createState() => _userNameScreenState();
}

class _userNameScreenState extends State<userNameScreen> {
  TextEditingController nameController = TextEditingController();
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
                "Tell us your name",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 90,
              ),
              Text(
                "Enter your name as seen on your profile",
                style: TextStyle(
                    fontSize: ScreenConfig.screenWidth / 55,
                    color: Color(0xff8C8E8F),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 90,
              ),
              CustomTextField(
                textFieldController: nameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: ScreenConfig.screenHeight / 5,
              ),
              CustomRectangleButton(
                title: "Continue",
                onClick: () {
                  if (nameController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter your name", context);
                  } else {
                    AuthViewModel.registerUser(nameController.text, context);
                  }
                },
                loading: authViewModel.loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
