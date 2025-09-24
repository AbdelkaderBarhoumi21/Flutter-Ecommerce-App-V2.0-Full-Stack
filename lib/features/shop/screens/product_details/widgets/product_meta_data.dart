import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/enums.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/images/circular_images.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/brand_title_verify_icon.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/product_price.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/product_title_text.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';

class AppProductMetaData extends StatelessWidget {
  const AppProductMetaData({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercantage(
      productModel.price,
      productModel.salePrice,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price title stock and brand
        //sale tag price old and new price share butto
        Row(
          children: [
            //sale tag
            //... becasue we have more then one statement that return a widget
            if (salePercentage != null) ...[
              AppRoundedContainer(
                radius: AppSizes.sm,
                backgroundColor: AppColors.primary.withValues(alpha: 0.8),
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
              SizedBox(width: AppSizes.spaceBtwItems),
            ],

            //sale price
            if (productModel.productType == ProductType.single.toString() &&
                productModel.salePrice > 0) ...[
              Text(
                "${AppTexts.currency}${productModel.price.toStringAsFixed(0)}",
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: AppSizes.spaceBtwItems),
            ],

            //actual price or sale price
            AppProductPriceText(
              price: controller.getProductPrice(productModel),
              isLarge: true,
            ),
            Spacer(),
            //share button
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        //product title
        AppProductTitleText(title: productModel.title),
        SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        //product status
        Row(
          children: [
            AppProductTitleText(title: "Status"),
            SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              controller.getProductStockStatus(productModel.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        //product brand image with title
        Row(
          children: [
            //brand image
            AppCircularImage(
              padding: 0,
              isNetworkImage: true,
              image: productModel.brand != null
                  ? productModel.brand!.image
                  : '',
              width: 32.0,
              height: 32.0,
            ),
            SizedBox(width: AppSizes.spaceBtwItems),
            //brand card
            AppBrandTitleVerifyIcon(
              title: productModel.brand != null
                  ? productModel.brand!.name
                  : '',
            ),
          ],
        ),
      ],
    );
  }
}
