import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/icons/circular_icon.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/images/rounded_image.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/brand_title_verify_icon.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/product_price.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/product_title_text.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/product_details/product_details_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppProductCardVertical extends StatelessWidget {
  const AppProductCardVertical({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercantage(
      productModel.price,
      productModel.salePrice,
    );
    return GestureDetector(
      onTap: () =>
          Get.to(() => ProductDetailsScreen(productModel: productModel)),
      child: Container(
        width: 180,
        // padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          // boxShadow: AppShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark
              ? AppColors.darkerGrey
              : AppColors.light.withValues(alpha: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //thumbail favorite button and discount tag
            AppRoundedContainer(
              height: 160,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  //thumbail
                  Center(
                    child: AppRoundedImage(
                      imageUrl: productModel.thumbnail,
                      isNetworkImage: true,
                    ),
                  ),
                  //discount tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12.0,
                      child: AppRoundedContainer(
                        radius: AppSizes.sm,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm,
                          vertical: AppSizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: AppColors.black),
                        ),
                      ),
                    ),
                  //Favorite button
                  Positioned(
                    right: 0,
                    top: 0,
                    child: AppCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwItems / 2),
            //Details
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  AppProductTitleText(
                    title: productModel.title,
                    smallSize: true,
                  ),
                  SizedBox(height: AppSizes.spaceBtwItems / 2),
                  //product brand
                  AppBrandTitleVerifyIcon(title: productModel.brand!.name),
                ],
              ),
            ),
            Spacer(),
            //product price - add button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.sm),
                  child: AppProductPriceText(
                    price: controller.getProductPrice(productModel),
                  ),
                ),
                //add button
                Container(
                  width: AppSizes.iconLg * 1.2,
                  height: AppSizes.iconLg * 1.2,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.cardRadiusMd),
                      bottomRight: Radius.circular(AppSizes.productImageRadius),
                    ),
                  ),
                  child: Icon(Iconsax.add, color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
