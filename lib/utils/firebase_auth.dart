import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var verificationId = "".obs; // store verificationId
  var isOTPSent = false.obs;

  // EMAIL LOGIN
  Future<void> signIn(String email, String password) async {
    try {
      isLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      goToHome();
    } catch (e) {
      Get.snackbar('Login Failed', "Invalid email or password.");
    } finally {
      isLoading(false);
    }
  }

  // EMAIL SIGNUP
  Future<void> signUp(String email, String password) async {
    try {
      isLoading(true);
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      goToHome();
    } catch (e) {
      Get.snackbar('Sign Up Failed', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // GOOGLE LOGIN
  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading(false);
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      goToHome();
    } catch (e) {
      Get.snackbar("Google Login Failed", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // 🔢 VERIFY OTP
  Future<void> verifyOTP(String otp) async {
    try {
      isLoading(true);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential);
      goToHome();

    } catch (e) {
      Get.snackbar("Invalid OTP", "Please enter correct OTP");
    } finally {
      isLoading(false);
    }
  }

  void goToHome() {
    Get.offAllNamed('/commonScreen');
  }
}