import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/layouts/grid_layout.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/products/products_card/product_vertical_card.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/section_heading.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/home/home_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/all_products/all_products_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/textfields/search_bar.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/custom_shapes/primary_header_container.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final productController = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Upper part
            Stack(
              children: [
                //Total height + 20
                SizedBox(height: AppSizes.homePrimaryHeaderHeight + 10),
                //Primary Header Container
                AppPrimaryHeaderContainer(
                  height: AppSizes.homePrimaryHeaderHeight,
                  child: Column(
                    children: [
                      AppHomeAppBar(),
                      SizedBox(height: AppSizes.spaceBtwSections),

                      AppHomeCategories(),
                    ],
                  ),
                ),
                //search bar
                AppSearchBar(),
              ],
            ),
            // SizedBox(height: AppSizes.defaultSpace),
            //lower part
            //banners
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  //slider banner
                  AppPromoSlider(),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  //products
                  //section headings
                  AppSectionHeading(
                    title: AppTexts.popularProducts,
                    onPressed: () => Get.to(() => AllProductsScreen()),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  //Grid of product card
                  Obx(() {
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productController.featuredProducts.isEmpty) {
                      return Center(child: Text("Products Not Found!"));
                    }
                    return AppGridLayout(
                      itemCount: productController.featuredProducts.length,
                      itemBuilder: (context, index) {
                        ProductModel product =
                            productController.featuredProducts[index];
                        return AppProductCardVertical(productModel: product);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
