import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppAnimationLoader extends StatelessWidget {
  const AppAnimationLoader({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //animation
          Lottie.asset(AppImages.loadingAnimation, width: Get.width * 0.8),
          const SizedBox(height: AppSizes.defaultSpace),
          //title
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.defaultSpace),
        ],
      ),
    );
  }
}
