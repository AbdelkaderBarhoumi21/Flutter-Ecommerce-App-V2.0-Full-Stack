import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/shimmer_effect.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
class AppBrandsShimmer extends StatelessWidget {
  const AppBrandsShimmer({super.key,this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(width: AppSizes.spaceBtwItems),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) => AppShimmerEffect(width: AppSizes.brandCardWidth, height: AppSizes.brandCardHeight),
    );
  }
}
