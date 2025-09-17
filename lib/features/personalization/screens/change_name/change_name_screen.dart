import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/elevated_button.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/change_name_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      //appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Update Name',
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
                key: controller.updateFormKey,
                child: Column(
                  children: [
                    //first name
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          AppValidator.validateEmptyText('First Name', value),
                      decoration: InputDecoration(
                        labelText: AppTexts.firstName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    SizedBox(height: AppSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          AppValidator.validateEmptyText('Last Name', value),
                      decoration: InputDecoration(
                        labelText: AppTexts.lastName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              AppElevatedButton(onPressed: () =>controller.updateUserName(), child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
