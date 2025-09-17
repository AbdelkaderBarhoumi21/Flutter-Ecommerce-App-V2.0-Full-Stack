import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/social_buttons.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/login_signup/form_divider.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header
              Text(
                AppTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              //form
              AppSignupForm(),
              SizedBox(height: AppSizes.spaceBtwSections),
              //Divider
              AppFormDivider(title: AppTexts.orSignupWith),
              SizedBox(height: AppSizes.spaceBtwSections),
              //Footer
              AppSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
