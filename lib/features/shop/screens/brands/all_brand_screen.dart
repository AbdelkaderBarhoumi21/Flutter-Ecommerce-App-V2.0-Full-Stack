import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/brand_shimmer.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/brand/brand_card.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/layouts/grid_layout.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/section_heading.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/brands/brand_products_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController
        .instance; //in store screen we already stored Brand COntroller in memory so dont put it again

    return Scaffold(
      // appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text("Brand", style: Theme.of(context).textTheme.headlineMedium),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //text brands
              AppSectionHeading(title: 'Brands', showActionsButtons: false),
              SizedBox(height: AppSizes.spaceBtwItems),
              //list of brand
              Obx(() {
                //loading state
                if (controller.isBrandLoading.value) {
                  return AppBrandsShimmer();
                }
                //empty state
                if (controller.allBrands.isEmpty) {
                  return Text('Brands Not Found!');
                }
                //found data state
                return AppGridLayout(
                  itemCount: controller.allBrands.length,
                  itemBuilder: (context, index) {
                    BrandModel brand = controller.allBrands[index];
                    return AppBrandCard(
                      brandModel: brand,
                      onTap: () => Get.to(() => BrandProductsScreen()),
                    );
                  },
                  mainAxisExtent: 80,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
