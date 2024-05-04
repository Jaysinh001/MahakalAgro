import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practical_assessment_app/utils/routes/routes.dart';
import 'package:practical_assessment_app/utils/routes/routes_name.dart';
import 'package:practical_assessment_app/utils/utils.dart';
import 'package:practical_assessment_app/view/otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    log("setted : $_loading");
    notifyListeners();
  }

  static sendOTP(String phoneNumber, BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    authViewModel.setLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$phoneNumber',
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
            // prefs.setString('phoneNumber', phoneNumber);
          },
          verificationFailed: (FirebaseAuthException e) {
            // Get.snackbar('verificationFailed Called', e.message.toString());
            Utils.flushBarErrorMessage(
                "verification Failed : ${e.toString()}", context);
            authViewModel.setLoading(false);
          },
          codeSent: (verificationId, forceResendingToken) {
            // Get.to(OTPScreen(
            //   firebaseOTP: verificationId,
            // ));
            authViewModel.setLoading(false);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtpScreen(firebaseVerificationId: verificationId)));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            authViewModel.setLoading(false);
          });
    } catch (e) {
      authViewModel.setLoading(false);
      // Get.snackbar('Exception Occured', e.toString());
      Utils.flushBarErrorMessage("Exception : ${e.toString()}", context);
    }
  }

  static void verifyOTP(String firebaseVerificationId, String userInputOTP,
      BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    authViewModel.setLoading(true);
    log("before PhoneAuthCredentials");
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseVerificationId, smsCode: userInputOTP);
    log("after PhoneAuthCredentials");
    // for signOut
    // await FirebaseAuth.instance.signOut();
    try {
      FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then(
          (value) => Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.userNameScreen, (route) {
                authViewModel.setLoading(false);

                return false;
              }));
    } on FirebaseAuthException catch (e) {
      authViewModel.setLoading(false);
      // Get.snackbar('FirebaseAuthException', e.message.toString());
      Utils.flushBarErrorMessage(
          "FirebaseAuth Exception : ${e.toString()}", context);
    } catch (e) {
      authViewModel.setLoading(false);
      // Get.snackbar('Exception:', e.toString());
      Utils.flushBarErrorMessage("Exception : ${e.toString()}", context);
    }
  }

  static void registerUser(String userName, BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    authViewModel.setLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? phone = prefs.getString('phoneNumber');

    Map<String, dynamic> data = {
      'email': 'example@gmail.com',
      'name': userName,
      'phone': phone,
    };

    await FirebaseFirestore.instance.collection("Users").doc(phone).set(data);
    authViewModel.setLoading(false);

    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.updateProfileScreen, (route) => false);
  }

  static Future<Map<String, dynamic>?> fetchUserData(
      String userId, BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('users').doc(userId);

    try {
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        Utils.flushBarErrorMessage("Failed to fetch user Data", context);
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
