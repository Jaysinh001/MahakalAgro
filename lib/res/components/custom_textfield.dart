import 'package:flutter/material.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textFieldController;
  final TextInputType keyboardType;

  const CustomTextField(
      {super.key,
      required this.textFieldController,
      required this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenHeight / 10,
      child: TextField(
        showCursor: true,
        cursorColor: Colors.black,
        // focusNode: primaryFocus,
        controller: widget.textFieldController,
        autofocus: true,
        enabled: true,
        keyboardType: widget.keyboardType,
        style: TextStyle(
            fontSize: ScreenConfig.screenWidth / 30,
            letterSpacing: -0.5,
            fontWeight: FontWeight.bold),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
