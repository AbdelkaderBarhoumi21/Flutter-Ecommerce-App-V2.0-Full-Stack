import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/login_signup/form_divider.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/login/widgets/login_formfield.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/social_buttons.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //header
              //title & subtitle
              AppLoginHeader(),
              SizedBox(height: AppSizes.spaceBtwSections),

              //form
              AppLoginForm(),
              SizedBox(height: AppSizes.spaceBtwSections),

              //divider
              AppFormDivider(title: AppTexts.orSignInWith),
              SizedBox(height: AppSizes.spaceBtwSections),
              //footer
              //social Button
              AppSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
