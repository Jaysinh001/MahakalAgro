import 'package:flutter/material.dart';
import 'package:practical_assessment_app/utils/routes/routes.dart';
import 'package:practical_assessment_app/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/viewModel/auth_viewModel.dart';
import 'package:practical_assessment_app/viewModel/button_loading_provider.dart';
import 'package:practical_assessment_app/viewModel/language_selection_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenConfig(context: context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageSelectorProvider()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => ButtonLoadingProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
