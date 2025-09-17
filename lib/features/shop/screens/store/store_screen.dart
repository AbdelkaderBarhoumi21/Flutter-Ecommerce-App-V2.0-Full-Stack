import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/brand_shimmer.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/tabBar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/brand/brand_card.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/texts/section_heading.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/brands/all_brand_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/store/widgets/primary_header_store.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final controller = CategoryController.instance;
    return DefaultTabController(
      length: controller.feautredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                // snap: true,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      //primary header
                      AppStorePrimaryHeader(),
                      SizedBox(height: AppSizes.spaceBtwItems),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            //brand herading
                            AppSectionHeading(
                              title: 'Brands',
                              onPressed: () => Get.to(() => AllBrandScreen()),
                            ),
                            //Brand Card
                            SizedBox(
                              height: AppSizes.brandCardHeight,
                              child: Obx(() {
                                //loading state 
                                if (brandController.isBrandLoading.value) {
                                  return AppBrandsShimmer();
                                }
                                //empty state
                                if (brandController.featureBrands.isEmpty) {
                                  return Text('Brands Not Found');
                                }
                                //data found state 
                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        width: AppSizes.spaceBtwItems / 2,
                                      ),
                                  shrinkWrap: true,
                                  itemCount:
                                      brandController.featureBrands.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    BrandModel brand =
                                        brandController.featureBrands[index];
                                    return SizedBox(
                                      width: AppSizes.brandCardWidth,
                                      child: AppBrandCard(brandModel: brand),
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //TabBar categories
                bottom: AppTabBar(
                  tabs: controller.feautredCategories
                      .map((catgeory) => Tab(child: Text(catgeory.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: controller.feautredCategories
                .map((catgeory) => AppCategoryTab())
                .toList(),
          ),
        ),
      ),
    );
  }
}
