import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/elevated_button.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header
              //---title
              Text(
                AppTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text(
                AppTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwSections * 2),

              //---from
              Column(
                children: [
                  Form(
                    key: controller.forgetPasswordFormKey,
                    child: TextFormField(
                      controller: controller.email,
                      validator: (value) => AppValidator.validateEmail(value),
                      decoration: InputDecoration(
                        labelText: AppTexts.email,
                        prefixIcon: Icon(Iconsax.direct_right),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  AppElevatedButton(
                    onPressed: controller.sendPasswordResetEmail,
                    child: Text(AppTexts.submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
