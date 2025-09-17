import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/loaders/animation_loader.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class AppFullScreenLoader {
  //open a dialog on the entire screen 
  static void openLoadingDialog(String text) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,

      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: AppHelperFunctions.isDarkMode(Get.context!)
              ? AppColors.dark
              : AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              //Extra sapce
              const SizedBox(height: 250),
              //Animation
              AppAnimationLoader(text: text),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
