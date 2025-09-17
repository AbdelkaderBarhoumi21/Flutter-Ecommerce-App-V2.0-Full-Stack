import 'package:ecommerce_application_fullsatck_v2/data/repositories/authentication_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/forget_password/reset_passowrd_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/network_manager.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();
  //!variables
  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  //!functions
  //send email to forget password
  Future<void> sendPasswordResetEmail() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog("Processing your request...");
      //check connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(title: "No internet Connection");
        return;
      }
      //form valdiation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );
      //stop loading
      AppFullScreenLoader.stopLoading();
      //success snackbars
      AppSnackBarHelpers.successSnackBar(
        title: "Email sent",
        message: 'Email Link Sent To Reset Passowrd',
      );
      //Go to login page
      Get.to(() => ResetPassowrdScreen(email: email.text.trim(),));
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      print(e);
    }
  }
  //resend password reset password email
  Future<void> resendPasswordResetEmail() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog("Processing your request...");
      //check connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(title: "No internet Connection");
        return;
      }
  
      AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );
      //stop loading
      AppFullScreenLoader.stopLoading();
      //success snackbars
      AppSnackBarHelpers.successSnackBar(
        title: "Email sent",
        message: 'Email Link Sent To Reset Passowrd',
      );

    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      print(e);
    }
  }
}
