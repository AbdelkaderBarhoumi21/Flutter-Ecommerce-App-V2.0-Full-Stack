import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/shimmer_effect.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/banner/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/images/rounded_image.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/home/home_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/home/widgets/banner_dot_navigation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AppPromoSlider extends StatelessWidget {
  const AppPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());
    return Obx(() {
      if (bannerController.isBannerLoading.value) {
        return AppShimmerEffect(width: double.infinity, height: 190);
      }
      if (bannerController.banners.isEmpty) {
        return Text('Banners Not Found');
      }
      return Column(
        children: [
          //carousel slider
          CarouselSlider(
            items: bannerController.banners
                .map(
                  (banner) => AppRoundedImage(
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                    onTap: () => Get.toNamed(banner.targetScreen),
                  ),
                )
                .toList(),

            options: CarouselOptions(
              onPageChanged: (index, reason) =>
                  bannerController.onPageChanged(index),
              viewportFraction: 1.0,
              padEnds: false, // évite le padding au tout début/fin
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              // autoPlay: true,
              // enableInfiniteScroll: true,//ifinity loop no limited to length
            ),
            carouselController: bannerController.carouselController,
          ),
          SizedBox(height: AppSizes.spaceBtwItems),
          //dot navigation banner
          BannerDotNavigation(),
        ],
      );
    });
  }
}
