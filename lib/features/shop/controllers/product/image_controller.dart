import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/button/outline_button.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  //Variables
  RxString selectedProductImage = ''.obs;
  //function to load all images of product
  List<String> getAllProductImages(ProductModel product) {
    //set type canot hold duplicate value
    Set<String> images = {};
    //load thumbnail images
    images.add(product.thumbnail);

    //assign thumbnail as seleected image
    selectedProductImage.value = product.thumbnail;
    //load all images of product
    if (product.images != null && product.images!.isNotEmpty) {
      images.addAll(product.images!);
    }
    //load all images for variation product
    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {
      List<String> variationImages = product.productVariations!
          .map((variatrion) => variatrion.image)
          .toList();
      images.addAll(variationImages);
    }
    return images.toList();
  }

  void showEnLargeImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        backgroundColor: AppColors.white,
        child: Column(
          children: [
            //image
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.defaultSpace * 2,
                horizontal: AppSizes.defaultSpace,
              ),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            //close button
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: Get.back,
                  child: Text("Close"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
