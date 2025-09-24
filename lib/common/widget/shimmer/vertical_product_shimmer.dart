import 'package:ecommerce_application_fullsatck_v2/common/widget/layouts/grid_layout.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/shimmer_effect.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
class AppVerticalProductShimmer extends StatelessWidget {
  const AppVerticalProductShimmer({
    super.key,
    this.itemCount = 16
  });

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return AppGridLayout(
        itemCount: itemCount,
        itemBuilder: (context, index) => const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              AppShimmerEffect(width: 180, height: 180),
              SizedBox(height: AppSizes.spaceBtwItems,),

              /// Text
              AppShimmerEffect(width: 160, height: 15),
              SizedBox(height: AppSizes.spaceBtwItems / 2,),
              AppShimmerEffect(width: 110, height: 15)
            ],
          ),
        ),
    );
  }
}
