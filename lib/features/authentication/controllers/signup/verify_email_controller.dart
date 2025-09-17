import 'dart:async';

import 'package:ecommerce_application_fullsatck_v2/common/widget/screens/success_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/authentication_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //!varibales
  
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAUtoRedirect();
    super.onInit();
  }

  //send email verification linked to current user
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerificatuion();
      AppSnackBarHelpers.successSnackBar(
        title: "Email Sent",
        message: 'Please check your inbox verify your email',
      );
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  //timer to automaically redirect on email verification
  void setTimerForAUtoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            title: AppTexts.accountCreatedTitle,
            subTitle: AppTexts.accountCreatedSubTitle,
            image: AppImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }
   //Manually check if email is verified 
  Future<void> checkEmailverificationStatus() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.emailVerified) {
        Get.off(
          () => SuccessScreen(
            title: AppTexts.accountCreatedTitle,
            subTitle: AppTexts.accountCreatedSubTitle,
            image: AppImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
