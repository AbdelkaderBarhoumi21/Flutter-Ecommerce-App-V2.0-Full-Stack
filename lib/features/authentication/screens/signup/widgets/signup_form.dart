import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/elevated_button.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/validators/validation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';

class AppSignupForm extends StatelessWidget {
  const AppSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signUpFromKey,
      child: Column(
        children: [
          Row(
            children: [
              //first name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      AppValidator.validateEmptyText('First Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: AppTexts.firstName,
                  ),
                ),
              ),
              SizedBox(width: AppSizes.spaceBtwInputFields),
              //last name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Last Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: AppTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),
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
          //phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => AppValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.call),
              labelText: AppTexts.phoneNumber,
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwInputFields),
          //password
          GetBuilder<SignupController>(
            builder: (controller) => TextFormField(
              obscureText: controller.isPasswordVisible,
              controller: controller.password,
              validator: (value) => AppValidator.validatePassword(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: AppTexts.password,
                suffixIcon: IconButton(
                  onPressed: () => controller.showPassword(),
                  icon: Icon(
                    controller.isPasswordVisible
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: AppSizes.spaceBtwInputFields / 2),
          //policy privacy
          AppPrivacyPolicyChekcBox(),
          SizedBox(height: AppSizes.spaceBtwItems),
          //create button
          AppElevatedButton(
            onPressed: () => controller.registerUser(),
            child: Text(AppTexts.createAccount),
          ),
        ],
      ),
    );
  }
}
