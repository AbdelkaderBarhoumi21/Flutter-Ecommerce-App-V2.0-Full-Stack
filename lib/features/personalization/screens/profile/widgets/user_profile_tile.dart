import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/edit_profile/edit_profile_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppUserProfileTile extends StatelessWidget {
  const AppUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Obx(
        () => Text(
          controller.user.value.fullName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      subtitle: Obx(
        () => Text(
          controller.user.value.email,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => EditProfileScreen()),
        icon: Icon(Iconsax.edit),
      ),
    );
  }
}
