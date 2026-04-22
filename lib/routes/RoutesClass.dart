import 'package:get/get.dart';
// import 'package:yamzi/Modules/screens/common_screen.dart';
import 'package:yamzi/Modules/screens/profile_management/main_profile_screen.dart';
import 'package:yamzi/Modules/screens/authenticationMangement/splash_screen.dart';
import '../Modules/controllers/thali_details_controller.dart';
import '../Modules/screens/customThaliManagement/Customization_Thali.dart';
import '../Modules/screens/dashBoardManagement/home_Screen.dart';
import '../Modules/screens/authenticationMangement/login_screen.dart';
import '../Modules/screens/profile_management/order_screen.dart';
import '../Modules/screens/authenticationMangement/sign_up_Screen.dart';
import '../Modules/screens/dashBoardManagement/thali_details_screen.dart';

class RoutesClass {

  static String splash = '/splash';
  static String login = '/login';
  static String otp = "/otp";
  static String home = "/home";
  static String signup = "/signup";
  // static String commonScreen = "/commonScreen";
  static String orderScreen = "/orderScreen";
  static String customScreen = "/customScreen";
  static String thaliDetailScreen = "/thaliDetailScreen";
  static String profileScreen = "/profileScreen";


  static String gotoSplash() => splash;
  static String gotoLogin() => login;
  static String gotohomeScreen() => home;
  static String gotoSignUpScreen() => signup;
  // static String gotoCommonScreen() => commonScreen;
  static String gotoOrderScreen() => orderScreen;
  static String gotocustomScreen() => customScreen;
  static String gotoThaliDetailScreen() => thaliDetailScreen;
  static String gotoprofileScreen() => profileScreen;


  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: signup,
      page: () => SignUpScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // GetPage(
    //   name: commonScreen,
    //   page: () => CommonScreen(),
    //   transition: Transition.fade,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    GetPage(
      name: orderScreen,
      page: () => OrderScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: customScreen,
      page: () => CustomizationScreen(),
      transition: Transition.fade,
      transitionDuration:  Duration(milliseconds: 300),
    ),
    GetPage(
      name: thaliDetailScreen,
      page: () => ThaliDetailScreen(),
      transition: Transition.fade,
      transitionDuration:  Duration(milliseconds: 300),
      binding: BindingsBuilder(() {
        Get.create(() => ThaliDetailController());
      }),
    ),
    GetPage(
      name: profileScreen,
      page: () => StylishProfileScreen(),
      transition: Transition.fade,
      transitionDuration:  Duration(milliseconds: 300),
    ),

  ];
}