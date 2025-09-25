import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/brand_model.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/brand/brand_card.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/products/sortable_products.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({
    super.key,
    required this.title,
    required this.brandModel,
  });
  final String title;
  final BrandModel brandModel;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //brand
              AppBrandCard(brandModel: brandModel),
              SizedBox(height: AppSizes.spaceBtwSections),
              //brand products
              FutureBuilder(
                future: controller.getBrandProducts(brandModel.id),
                builder: (context, asyncSnapshot) {
                  //handle loading error and empty state
                  final looader = AppVerticalProductShimmer();
                  Widget? widget =
                      AppCloudHelperFunctions.checkMultiRecordState(
                        snapshot: asyncSnapshot,
                        loader: looader,
                      );
                  if (widget != null) return widget;
                  //data found
                  List<ProductModel> products = asyncSnapshot.data!;
                  return AppSortableProducts(productModel: products);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
