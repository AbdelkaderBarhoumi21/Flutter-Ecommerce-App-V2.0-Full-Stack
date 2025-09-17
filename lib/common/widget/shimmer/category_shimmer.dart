import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'shimmer_effect.dart';
class AppCategoryShimmer extends StatelessWidget {
  const AppCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: AppSizes.spaceBtwItems),
        itemBuilder: (context, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              AppShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: AppSizes.spaceBtwItems / 2),

              /// Text
              AppShimmerEffect(width: 55, height: 8)
            ],
          );
        },
      ),
    );
  }
}
