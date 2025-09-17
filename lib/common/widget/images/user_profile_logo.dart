import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/shimmer_effect.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/images/circular_images.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AppUserProfileLogo extends StatelessWidget {
  const AppUserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(() {
      bool isProfileAvailable = controller.user.value.profilePicture.isNotEmpty;
      if (controller.isProfileUploading.value) {
        return AppShimmerEffect(width: 120, height: 120, radius: 120);
      }

      return AppCircularImage(
        isNetworkImage: isProfileAvailable ? true : false,
        image: isProfileAvailable
            ? controller.user.value.profilePicture
            : AppImages.profileLogo,
        height: 120.0,
        width: 120.0,
        borderWidth: 5.0,
        padding: 0,
      );
    });
  }
}
