import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/authentication_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/user/user_repositroy.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/models/user_model.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/network_manager.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variables
  final signUpFromKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  bool isPasswordVisible = false;
  RxBool privacyPolicy = false.obs;
  final userRepository = Get.put(UserRepositroy());

  ///show password function
  void showPassword() {
    isPasswordVisible = isPasswordVisible == true ? false : true;
    update();
  }

  ///function to regider user with email and password
  Future<void> registerUser() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog(
        "We are processing your information.....",
      );

      //check internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }
      //check privacy policy
      if (!privacyPolicy.value) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(
          title: "Accept Privacy Policy",
          message:
              'In Order to create account, you must have to read and accept the privacy policy',
        );
        return;
      }

      //from validation
      if (!signUpFromKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      //regiser user using firebase auth
      UserCredential userCredential = await AuthenticationRepository.instance
          .registerUser(email.text.trim(), password.text.trim());

      //create user model
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: '${firstName.text.trim()}${lastName.text.trim()}23176',
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );
      //save user record
      await userRepository.saveUserRecord(userModel);
      //success message
      AppSnackBarHelpers.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue',
      );
      //stop loading
      AppFullScreenLoader.stopLoading();
      //redirect to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      //stop loading
      AppFullScreenLoader.stopLoading();
      AppSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      print(e);
    }
  }
}
