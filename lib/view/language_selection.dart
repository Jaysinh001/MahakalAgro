import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practical_assessment_app/res/app_colors.dart';
import 'package:practical_assessment_app/res/components/custom_rectangle_button.dart';
import 'package:practical_assessment_app/utils/routes/routes_name.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/viewModel/auth_viewModel.dart';
import 'package:practical_assessment_app/viewModel/button_loading_provider.dart';
import 'package:practical_assessment_app/viewModel/language_selection_provider.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  ValueNotifier<bool> isEnglishSelected = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    log("build");
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
              "Choose App Language",
              style: TextStyle(
                  fontSize: ScreenConfig.screenWidth / 30,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: ScreenConfig.screenHeight / 90,
            ),
            Text(
              "Please select your prefered language",
              style: TextStyle(
                  fontSize: ScreenConfig.screenWidth / 55,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: ScreenConfig.screenHeight / 15,
            ),
            Consumer<LanguageSelectorProvider>(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    value.setLanguage(true);
                  },
                  child: LanguageSelectItem(
                      title: "English",
                      image: "assets/uk_flag.png",
                      isSelected: value.isEnglishSelected),
                );
              },
            ),
            SizedBox(
              height: ScreenConfig.screenHeight / 60,
            ),
            Consumer<LanguageSelectorProvider>(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    value.setLanguage(false);
                  },
                  child: LanguageSelectItem(
                      title: "Gujrati",
                      image: "assets/in_flag.png",
                      isSelected: !value.isEnglishSelected),
                );
              },
            ),
            SizedBox(
              height: ScreenConfig.screenHeight / 15,
            ),
            CustomRectangleButton(
                loading: authViewModel.loading,
                title: "Continue",
                onClick: () {
                  Navigator.pushNamed(context, RoutesName.phoneNumberScreen);
                })
          ],
        ),
      )),
    );
  }
}

class LanguageSelectItem extends StatefulWidget {
  final String title;
  final String image;
  bool isSelected;
  LanguageSelectItem(
      {super.key,
      required this.title,
      required this.image,
      required this.isSelected});

  @override
  State<LanguageSelectItem> createState() => LanguageSelectItemState();
}

class LanguageSelectItemState extends State<LanguageSelectItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenConfig.screenWidth,
      // height: ScreenConfig.screenHeight / 20,
      padding: EdgeInsets.symmetric(vertical: ScreenConfig.screenHeight / 80),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected
              ? AppColors.selectedbackgroundColor
              : AppColors.white,
          border: Border.all(
              color: widget.isSelected
                  ? AppColors.selectedBorderColor
                  : AppColors.unSelectedBorderColor)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: ScreenConfig.screenWidth / 60,
        ),
        CircleAvatar(
          radius: ScreenConfig.screenWidth / 50,
          backgroundImage: AssetImage(widget.image),
        ),
        SizedBox(
          width: ScreenConfig.screenWidth / 60,
        ),
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Spacer(),
        Consumer<LanguageSelectorProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return RoundCheckBox(
              onTap: (val) {
                value.setLanguage(val);
              },
              checkedColor: AppColors.checkboxColor,
              isChecked: widget.isSelected,
              size: ScreenConfig.screenWidth / 30,
            );
          },
        ),
        SizedBox(
          width: ScreenConfig.screenWidth / 50,
        )
      ]),
    );
  }
}
