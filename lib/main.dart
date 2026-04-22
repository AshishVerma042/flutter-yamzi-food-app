import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/routes/RoutesClass.dart';
import 'Modules/screens/authenticationMangement/splash_screen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    providerWeb: ReCaptchaV3Provider('6Lec2_krAAAAAEXgUUZckNIDRpz6vQ8nHVexw83Q'),
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: appColors.primaryColor,
      ),
      home: SplashScreen(),
      getPages: RoutesClass.routes,
      initialRoute: RoutesClass.gotoSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}


abstract class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});
  Widget buildingView(BuildContext context, double h, double w);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(resizeToAvoidBottomInset: false, body: buildingView(context, h, w));
  }
}
