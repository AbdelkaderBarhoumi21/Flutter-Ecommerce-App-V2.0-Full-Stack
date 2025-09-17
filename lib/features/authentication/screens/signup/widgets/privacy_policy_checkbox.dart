import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class AppPrivacyPolicyChekcBox extends StatelessWidget {
  const AppPrivacyPolicyChekcBox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value =
                !controller.privacyPolicy.value,
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(text: '${AppTexts.iAgreeTo} '),
              TextSpan(
                text: '${AppTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? AppColors.white : AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? AppColors.white : AppColors.primary,
                ),
              ),
              TextSpan(text: '${AppTexts.and} '),
              TextSpan(
                text: '${AppTexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? AppColors.white : AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? AppColors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
