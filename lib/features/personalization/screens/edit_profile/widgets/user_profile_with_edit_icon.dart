import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/icons/circular_icon.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/images/user_profile_logo.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppUserProfileWithEditIcon extends StatelessWidget {
  const AppUserProfileWithEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = UserController.instance;
    return Stack(
      children: [
        Center(child: AppUserProfileLogo()),
        Obx(() {
          if (controller.isProfileUploading.value) {
            return SizedBox();
          }
          return Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Center(
              child: AppCircularIcon(
                onPressed: () => controller.updateUserProfilePicture(),
                icon: Iconsax.edit,
                backgroundColor: dark
                    ? AppColors.dark.withValues(alpha: 0.7)
                    : AppColors.light.withValues(alpha: 0.7),
              ),
            ),
          );
        }),
      ],
    );
  }
}
