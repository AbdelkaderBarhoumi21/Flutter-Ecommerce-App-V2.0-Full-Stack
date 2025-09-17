import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/change_name/change_name_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/edit_profile/widgets/user_details_row.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/section_heading.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/edit_profile/widgets/user_profile_with_edit_icon.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //user profilfe with edit icon
              AppUserProfileWithEditIcon(),

              SizedBox(height: AppSizes.spaceBtwSections),
              //divider
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),

              //account settings heading
              AppSectionHeading(
                title: 'Account Settings',
                showActionsButtons: false,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),

              AppUserDetailsRow(
                title: 'Name',
                value: controller.user.value.firstName,
                onTap: () => Get.to(() => ChangeNameScreen()),
              ),
              AppUserDetailsRow(
                title: 'Username',
                value: controller.user.value.lastName,
                onTap: () {},
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //divider
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),
              //Profile Settings
              AppSectionHeading(
                title: 'Profile Settings',
                showActionsButtons: false,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              AppUserDetailsRow(
                title: 'User ID',
                value: controller.user.value.id,
                onTap: () {},
              ),
              AppUserDetailsRow(
                title: 'Email',
                value: controller.user.value.email,
                onTap: () {},
              ),
              AppUserDetailsRow(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onTap: () {},
              ),
              AppUserDetailsRow(title: 'Gender', value: 'Male', onTap: () {}),
              SizedBox(height: AppSizes.spaceBtwItems),

              //divider
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),
              //close account button
              TextButton(
                onPressed: () => controller.deleteAccoountWarningPopup(),
                child: Text(
                  "Close Account",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.apply(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
