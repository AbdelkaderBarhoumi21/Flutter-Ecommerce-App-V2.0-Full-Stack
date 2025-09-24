import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/chips/choice_chip.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/product_price.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/product_title_text.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/section_heading.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class AppProductAttributes extends StatelessWidget {
  const AppProductAttributes({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          // selected attributes pricing description
          if (controller.selectedVariation.value.id.isNotEmpty)
            AppRoundedContainer(
              padding: EdgeInsets.all(AppSizes.md),
              backgroundColor: dark ? AppColors.darkerGrey : AppColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title price stock
                  Row(
                    children: [
                      //variation heading
                      AppSectionHeading(
                        title: 'Variation',
                        showActionsButtons: false,
                      ),
                      SizedBox(width: AppSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //price sale price actual price
                          Row(
                            children: [
                              //price heading
                              AppProductTitleText(
                                title: 'Price : ',
                                smallSize: true,
                              ),
                              SizedBox(width: AppSizes.spaceBtwItems),
                              //old price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '${AppTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              SizedBox(width: AppSizes.spaceBtwItems / 1.5),
                              //actual price
                              AppProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),
                          //stock status
                          Row(
                            children: [
                              AppProductTitleText(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              SizedBox(width: AppSizes.spaceBtwItems),
                              Text(
                                controller.variationStockStatus(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(width: AppSizes.spaceBtwItems),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: AppSizes.spaceBtwItems),
                  //attributes description
                  AppProductTitleText(
                    title:
                        controller.selectedVariation.value.description ??
                        'This is a product of iPhone 11 with 512 GB',
                    smallSize: true,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          SizedBox(height: AppSizes.spaceBtwItems),
          //attributes - color
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: productModel.productAttributes!.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSectionHeading(
                    title: attribute.name ?? '',
                    showActionsButtons: false,
                  ),
                  SizedBox(height: AppSizes.spaceBtwItems / 2),
                  Obx(
                    () => Wrap(
                      spacing: AppSizes.sm,
                      children: attribute.values!.map((attributeValue) {
                        final bool isSelected =
                            controller.selectedAttributes[attribute.name] ==
                            attributeValue;
                        bool available = controller
                            .getAttributesAvailabilityInVariation(
                              productModel.productVariations!,
                              attribute.name!,
                            )
                            .contains(attributeValue);
                        return AppChoiceChip(
                          text: attributeValue,
                          selected: isSelected,
                          onSelected: available
                              ? (selected) {
                                  if (available && selected) {
                                    controller.onAttributeSelected(
                                      productModel,
                                      attribute.name,
                                      attributeValue,
                                    );
                                  }
                                }
                              : null,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: AppSizes.spaceBtwItems / 1.5),

          //attributes - size
        ],
      ),
    );
  }
}
