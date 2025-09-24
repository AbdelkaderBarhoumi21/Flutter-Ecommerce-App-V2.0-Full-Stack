import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/image_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/icons/circular_icon.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/images/rounded_image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppProductThumbnailAndSlider extends StatelessWidget {
  const AppProductThumbnailAndSlider({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    List<String> images = controller.getAllProductImages(productModel);

    return Container(
      color: dark ? AppColors.darkerGrey : AppColors.light,
      child: Stack(
        children: [
          //image thumnail
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.productImageRadius * 2),
              child: Center(
                child: Obx(() {
                  final images = controller.selectedProductImage.value;
                  return GestureDetector(
                    onTap: () => controller.showEnLargeImage(images),
                    child: CachedNetworkImage(
                      imageUrl: images,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(
                            color: AppColors.primary,
                            value: progress.progress,
                          ),
                    ),
                  );
                }),
              ),
            ),
          ),
          //image slider
          Positioned(
            left: AppSizes.defaultSpace,
            right: 0,
            bottom: 20,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: AppSizes.spaceBtwItems),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,

                itemCount: images.length,
                itemBuilder: (context, index) => Obx(() {
                  bool isImageSelected =
                      controller.selectedProductImage.value == images[index];
                  return AppRoundedImage(
                    width: 80,
                    onTap: () =>
                        controller.selectedProductImage.value = images[index],
                    isNetworkImage: true,
                    padding: EdgeInsets.all(AppSizes.sm),
                    border: Border.all(
                      color: isImageSelected
                          ? AppColors.primary
                          : Colors.transparent,
                    ),
                    backgroundColor: dark ? AppColors.dark : AppColors.light,
                    imageUrl: images[index],
                  );
                }),
              ),
            ),
          ),
          //App bar back arrow favorite icon
          UAppBar(
            showBackArrow: true,
            actions: [AppCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
          ),
        ],
      ),
    );
  }
}
