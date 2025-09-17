import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/elevated_button.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUserForm extends StatelessWidget {
  const ReAuthenticateUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      //appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Re-Authenticate User',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //text heading
              Text(
                "Update your name to keep your profile accurate and personalized",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              Form(
                key: controller.reAuthFormKey,
                child: Column(
                  children: [
                    //first name
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => AppValidator.validateEmail(value),
                      decoration: InputDecoration(
                        labelText: AppTexts.email,
                        prefixIcon: Icon(Iconsax.direct_right),
                      ),
                    ),
                    SizedBox(height: AppSizes.spaceBtwInputFields),
                    Obx(
                      () => TextFormField(
                        obscureText: controller.isPasswordVisible.value,
                        controller: controller.password,
                        validator: (value) =>
                            AppValidator.validateEmptyText('Password', value),
                        decoration: InputDecoration(
                          labelText: AppTexts.password,
                          prefixIcon: Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                // controller.isPasswordVisible.toggle(),
                                controller.showPassowrd(),
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              //verify button
              AppElevatedButton(
                onPressed: () => controller.reAuthenticateUSer(),
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
