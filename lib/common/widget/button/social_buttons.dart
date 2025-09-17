import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AppSocialButtons extends StatelessWidget {
  const AppSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(AppImages.googleIcon, controller.googleSignIn),
        SizedBox(width: AppSizes.spaceBtwItems),
        buildButton(AppImages.facebookIcon, () {}),
      ],
    );
  }
}

Container buildButton(String image, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.grey),
      borderRadius: BorderRadius.circular(100),
    ),
    child: IconButton(
      onPressed: onPressed,
      icon: Image.asset(image, height: AppSizes.iconMd, width: AppSizes.iconMd),
    ),
  );
}
