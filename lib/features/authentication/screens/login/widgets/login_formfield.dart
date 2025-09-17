import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/login/login_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/elevated_button.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/outline_button.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/signup/signup.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppLoginForm extends StatelessWidget {
  const AppLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginKeyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //email
          TextFormField(
            controller: controller.email,
            validator: (value) => AppValidator.validateEmail(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: AppTexts.email,
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),
          //password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) =>
                  AppValidator.validateEmptyText('Password', value),
              obscureText: controller.isPasswordVisible.value,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: AppTexts.password,
                suffixIcon: IconButton(
                  //or
                  onPressed: () => controller.isPasswordVisible.toggle(),
                  // onPressed: () => controller.showPassowrd(),
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields / 2),
          //remeber me
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.rememberMe.toggle(),
                    ),
                  ),
                  Text(
                    AppTexts.rememberMe,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Get.to(() => ForgetPasswordScreen()),
                child: Text(
                  AppTexts.forgetPassword,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.apply(color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spaceBtwSections),
          //SignIn Button
          AppElevatedButton(
            onPressed: () => controller.loginWithEmailAndPasword(),
            child: Text(AppTexts.signIn),
          ),
          SizedBox(height: AppSizes.spaceBtwItems / 2),
          //create account button
          AppOutlineButton(
            onPressed: () => Get.to(() => SignupScreen()),
            child: Text(AppTexts.createAccount),
          ),
        ],
      ),
    );
  }
}
