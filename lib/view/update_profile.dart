import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practical_assessment_app/res/app_colors.dart';
import 'package:practical_assessment_app/res/components/custom_rectangle_button.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/utils/utils.dart';
import 'package:practical_assessment_app/view/popup.dart';
import 'package:practical_assessment_app/viewModel/auth_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  initState() {
    super.initState();

    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString("phoneNumber");
    final docRef = FirebaseFirestore.instance.collection("Users").doc(phone);

    docRef.get().then(
      (DocumentSnapshot doc) {
        userData = doc.data() as Map<String, dynamic>;
      },
      onError: (e) =>
          Utils.flushBarErrorMessage("Failed to load Data", context),
    );

    log(userData.toString());
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            // center black container
            Container(
              height: ScreenConfig.screenHeight / 4.5,
              width: ScreenConfig.screenWidth,
              padding: EdgeInsets.only(
                  top: ScreenConfig.screenHeight / 12,
                  left: ScreenConfig.screenWidth / 40),
              decoration: const BoxDecoration(
                color: AppColors.containerBlackBackgroundColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
              ),
              child: const Text(
                "My Profile",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
              ),
            ),

            Positioned(
              top: ScreenConfig.screenHeight / 5.8,
              left: ScreenConfig.screenWidth / 5.7,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        const AssetImage("assets/profile_picture.png"),
                    radius: ScreenConfig.screenWidth / 18,
                  ),
                  Positioned(
                    top: ScreenConfig.screenWidth / 17,
                    left: ScreenConfig.screenWidth / 15,
                    child: IconButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(0.0),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.white,
                          size: ScreenConfig.screenWidth / 50,
                        )),
                  )
                ],
              ),
            ),

            // most bottom container in stack
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenConfig.screenWidth / 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenConfig.screenHeight / 3.5,
                  ),
                  const Text(
                    "Jaysinh Chauhan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: ScreenConfig.screenHeight / 40),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenConfig.screenWidth / 35,
                        vertical: ScreenConfig.screenWidth / 70),
                    // height: ScreenConfig.screenHeight / 5,
                    width: ScreenConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: AppColors.containerBlackBackgroundColor,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "AgroShop's Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                        ),
                        Container(
                          width: ScreenConfig.screenWidth,
                          padding:
                              EdgeInsets.all(ScreenConfig.screenWidth / 100),
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenConfig.screenHeight / 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xffB68301))),
                          child: const Text(
                            "MAH856BKR205DF62G3",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white),
                          ),
                        ),
                        const Text(
                          "Vishva Patel",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenConfig.screenHeight / 40,
                  ),
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Personal Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenConfig.screenHeight / 40,
                  ),
                  TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                        label: const Text(
                          "Name",
                          style: TextStyle(
                              color: AppColors.textfieldGreyBorderColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: ScreenConfig.screenHeight / 80,
                            horizontal: ScreenConfig.screenWidth / 80),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid))),
                  ),
                  SizedBox(
                    height: ScreenConfig.screenHeight / 40,
                  ),
                  TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                        label: const Text(
                          "Mobile Number",
                          style: TextStyle(
                              color: AppColors.textfieldGreyBorderColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: ScreenConfig.screenHeight / 80,
                            horizontal: ScreenConfig.screenWidth / 80),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid))),
                  ),
                  SizedBox(
                    height: ScreenConfig.screenHeight / 40,
                  ),
                  TextField(
                    controller: TextEditingController(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    decoration: InputDecoration(
                        label: const Text(
                          "Email Id",
                          style: TextStyle(
                              color: AppColors.textfieldGreyBorderColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: ScreenConfig.screenHeight / 80,
                            horizontal: ScreenConfig.screenWidth / 80),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textfieldGreyBorderColor,
                                style: BorderStyle.solid))),
                  ),
                  SizedBox(
                    height: ScreenConfig.screenHeight / 10,
                  ),
                  CustomRectangleButton(
                      loading: authViewModel.loading,
                      title: "Update Profile",
                      onClick: () {
                        // FirebaseAuth.instance.signOut();
                        showCupertinoModalPopup(
                            context: context, builder: buildActionSheet);
                      }),
                  SizedBox(
                    height: ScreenConfig.screenHeight / 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildActionSheet(BuildContext context) => CupertinoActionSheet(
        actions: [
          // ,
          CupertinoActionSheetAction(
            onPressed: () {},
            child: Container(
              height: ScreenConfig.screenHeight / 2,
              width: ScreenConfig.screenWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 6,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: FloatingActionButton.small(
                          clipBehavior: Clip.none,
                          onPressed: () {},
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            "assets/cancel.png",
                            height: MediaQuery.sizeOf(context).height / 72,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/product_purchased.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Congratulations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemGreen,
                      fontSize: 30.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Your order is placed succesfully',
                    style: TextStyle(
                      color: CupertinoColors.inactiveGray,
                      fontSize: 15.0,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "order id: ",
                        style: TextStyle(
                            color: CupertinoColors.inactiveGray, fontSize: 15),
                      ),
                      Text(
                        " abcdefg",
                        style: TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        width: MediaQuery.sizeOf(context).width / 1.15,
                        height: MediaQuery.sizeOf(context).height / 15,
                        child: FloatingActionButton.extended(
                          elevation: 0,
                          backgroundColor: CupertinoColors.activeBlue,
                          onPressed: () {},
                          label: Text(
                            "Done",
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
