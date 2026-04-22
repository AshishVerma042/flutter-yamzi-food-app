import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../../utils/firebase_auth.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              140.kH,
              Text(
                appStrings.yamzi,
                style: TextStyle(
                  color:  Color(0xFFFF5722) ,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              8.kH,
              Text(
                appStrings.welcomeBackFoodie,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),

              40.kH,

              commonTextField(
                controller: emailController,
                label: appStrings.emailUsername,
                icon: Icons.email_outlined,
              ),
              20.kH,

              commonTextField(
                controller: passwordController,
                label: appStrings.password,
                icon: Icons.lock_outline,
                obscure: true,
              ),
              30.kH,
              Obx(() => authC.isLoading.value
                  ?  CircularProgressIndicator(color: Color(0xFFFF5722))
                  : Column(
                children: [
                  ElevatedButton(
                    onPressed: ()  {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      if (email.isNotEmpty && password.isNotEmpty) {
                        authC.signUp(email, password);
                      } else {
                        Get.snackbar('Error', 'Enter email and password');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFFFF5722),
                      minimumSize:  Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child:  Text(
                      appStrings.signUp,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  32.kH,

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(appStrings.alreadyHaveAnAccount),
                      InkWell(onTap: (){
                        Get.to(() => LoginScreen());

                      },
                          child: Text(appStrings.signIn,style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),

                  20.kH,

                  OutlinedButton.icon(
                    icon: Image.asset(
                      'assets/images/google_logo.png',
                      height: 24,
                      width: 24,
                    ),
                    label:  Text(
                      appStrings.signUpWithGoogle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    onPressed: () {
                      authC.signInWithGoogle();
                    },
                    style: OutlinedButton.styleFrom(
                      side:  BorderSide(color: Colors.grey),
                      minimumSize:  Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              )),
              40.kH,
              Text(
                appStrings.yumzi2025,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
