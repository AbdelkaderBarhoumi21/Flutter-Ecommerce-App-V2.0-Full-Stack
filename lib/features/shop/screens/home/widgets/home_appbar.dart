import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/shimmer_effect.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/products/cart/cart_counter_icon.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:get/get.dart';

class AppHomeAppBar extends StatelessWidget {
  const AppHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return UAppBar(
      //title - subtitle
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text(
            AppHelperFunctions.getGreetingMessage(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: AppColors.grey),
          ),
          SizedBox(height: AppSizes.spaceBtwItems / 3),
          //subtitle
          Obx(() {
            if (controller.profileLoading.value) {
              return AppShimmerEffect(width: 140, height: 15);
            }
            return Text(
              controller.user.value.fullName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: AppColors.white),
            );
          }),
        ],
      ),
      actions: [AppCartCounterIcon()],
    );
  }
}
