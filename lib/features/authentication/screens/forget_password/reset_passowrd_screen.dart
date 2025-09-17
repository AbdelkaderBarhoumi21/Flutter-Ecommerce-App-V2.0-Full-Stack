import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/elevated_button.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/device_helpers.dart';
import 'package:get/get.dart';

class ResetPassowrdScreen extends StatelessWidget {
  const ResetPassowrdScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final conrtoller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //Image
              Image.asset(
                AppImages.mailSentImage,
                height: AppDeviceHelpers.getScreenHeight(context) * 0.4,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),

              //title
              Text(
                AppTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //email
              Text(email, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: AppSizes.spaceBtwItems),
              //subtitle
              Text(
                textAlign: TextAlign.center,
                AppTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              AppElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: Text(AppTexts.done),
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                width: AppDeviceHelpers.getScreenWidth(context),
                child: TextButton(
                  onPressed: () => conrtoller.resendPasswordResetEmail(),
                  child: Text(AppTexts.resendEmail),
                ),
              ),

              //Resend Email
            ],
          ),
        ),
      ),
    );
  }
}
