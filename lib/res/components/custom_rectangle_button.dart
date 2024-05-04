import 'package:flutter/material.dart';
import 'package:practical_assessment_app/res/app_colors.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/viewModel/auth_viewModel.dart';
import 'package:provider/provider.dart';

class CustomRectangleButton extends StatefulWidget {
  final String title;
  final VoidCallback onClick;
  final bool loading;

  const CustomRectangleButton(
      {super.key,
      required this.title,
      required this.onClick,
      required this.loading});

  @override
  State<CustomRectangleButton> createState() => _CustomRectangleButtonState();
}

class _CustomRectangleButtonState extends State<CustomRectangleButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return Ink(
          width: ScreenConfig.screenWidth,
          height: ScreenConfig.screenHeight / 18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.buttonPrimaryColor),
          child: InkWell(
            splashColor: AppColors.checkboxColor,
            onTap: widget.onClick,
            child: Center(
              child: widget.loading
                  ? const CircularProgressIndicator(
                      color: AppColors.white,
                    )
                  : Text(
                      widget.title,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
            ),
          ),
        );
      },
    );
  }
}
