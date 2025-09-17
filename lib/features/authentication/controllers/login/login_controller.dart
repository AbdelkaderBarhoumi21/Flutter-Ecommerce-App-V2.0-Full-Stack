import 'package:ecommerce_application_fullsatck_v2/data/repositories/authentication_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/network_manager.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //variables
  final email = TextEditingController();
  final password = TextEditingController();
  final loginKeyForm = GlobalKey<FormState>();
  final localStorage = GetStorage();
  final _userController = Get.put((UserController()));
  RxBool isPasswordVisible = false.obs;
  RxBool rememberMe = false.obs;
  @override
  void onInit() {
    email.text = localStorage.read(AppKeys.rememberMeEmail) ?? '';
    password.text = localStorage.read(AppKeys.rememberMePassword) ?? '';
    super.onInit();
  }

  void showPassowrd() {
    isPasswordVisible.value = isPasswordVisible.value == false ? true : false;
  }

  //login user with email and passowrd
  Future<void> loginWithEmailAndPasword() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog('Logging you in....');
      //cehck internet connectivity
      final isconnected = await NetworkManager.instance.isConnected();
      if (!isconnected) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      //check formsate validation
      if (!loginKeyForm.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      //save data if remember me is checked
      if (rememberMe.value) {
        localStorage.write(AppKeys.rememberMeEmail, email.text.trim());
        localStorage.write(AppKeys.rememberMePassword, password.text.trim());
      }

      //login user with email and password
      await AuthenticationRepository.instance.login(
        email.text.trim(),
        password.text.trim(),
      );
      //stop loading
      AppFullScreenLoader.stopLoading();
      //redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
      print(e);
    }
  }

  Future<void> googleSignIn() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog('Logging you in ...');
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }
      //google authentication
      UserCredential? userCredential = await AuthenticationRepository.instance
          .loginWithGoogle();
      //save user record
      await _userController.saveUserRecord(userCredential!);

      //stop looding
      AppFullScreenLoader.stopLoading();
      //redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      //stop loading
      AppFullScreenLoader.stopLoading();
      //error snack bar
      AppSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      print(e);
    }
  }
}
