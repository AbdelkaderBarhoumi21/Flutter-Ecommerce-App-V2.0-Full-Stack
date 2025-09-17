import 'package:ecommerce_application_fullsatck_v2/data/repositories/authentication_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/elevated_button.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/device_helpers.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: AuthenticationRepository.instance.logout,
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
                AppTexts.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //email
              Text(email ?? '', style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: AppSizes.spaceBtwItems),
              //subtitle
              Text(
                textAlign: TextAlign.center,
                AppTexts.verifyEmailSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              //continiue button
              SizedBox(height: AppSizes.spaceBtwItems),
              AppElevatedButton(
                // onPressed: () => controller.checkEmailverificationStatus(), //or
                onPressed: controller.checkEmailverificationStatus,
                child: Text(AppTexts.Continue),
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //resend email button
              SizedBox(
                width: AppDeviceHelpers.getScreenWidth(context),
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: Text(AppTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
