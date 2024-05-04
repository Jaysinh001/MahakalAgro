import 'package:flutter/material.dart';
import 'package:practical_assessment_app/utils/routes/routes_name.dart';
import 'package:practical_assessment_app/view/language_selection.dart';
import 'package:practical_assessment_app/view/otp_screen.dart';
import 'package:practical_assessment_app/view/phone_number_screen.dart';
import 'package:practical_assessment_app/view/splash.dart';
import 'package:practical_assessment_app/view/update_profile.dart';
import 'package:practical_assessment_app/view/user_name_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutesName.chooseLanguageScreen:
        return MaterialPageRoute(
            builder: ((context) => const LanguageSelectionScreen()));
      case RoutesName.phoneNumberScreen:
        return MaterialPageRoute(
            builder: ((context) => const PhoneNumberScreen()));
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      case RoutesName.otpScreen:
        return MaterialPageRoute(
            builder: ((context) => OtpScreen(
                  firebaseVerificationId: args.toString(),
                )));
      case RoutesName.userNameScreen:
        return MaterialPageRoute(
            builder: ((context) => const userNameScreen()));
      case RoutesName.updateProfileScreen:
        return MaterialPageRoute(
            builder: ((context) => const UpdateProfileScreen()));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(
                "No Route Is Defined",
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ),
          );
        });
    }
  }
}
