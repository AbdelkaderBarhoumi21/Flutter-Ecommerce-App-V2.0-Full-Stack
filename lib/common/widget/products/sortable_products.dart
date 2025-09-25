import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/all_product_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/layouts/grid_layout.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/products/products_card/product_vertical_card.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppSortableProducts extends StatelessWidget {
  const AppSortableProducts({super.key, required this.productModel});
  final List<ProductModel> productModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(productModel);
    return Column(
      children: [
        //filter field
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ['Name', 'Lower Price', 'Higher Price', 'Newest', 'Sale'].map((
            filter,
          ) {
            return DropdownMenuItem(value: filter, child: Text(filter));
          }).toList(),
          onChanged: (value) => controller.sortProducts(value!),
        ),
        SizedBox(height: AppSizes.spaceBtwSections),
        //products
        Obx(
          () => AppGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (context, index) => AppProductCardVertical(
              productModel: controller.products[index],
            ),
          ),
        ),
      ],
    );
  }
}
