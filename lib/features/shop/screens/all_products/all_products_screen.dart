import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/all_product_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/styles/padding.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/appbar/appbar.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/products/sortable_products.dart';
import 'package:get/get.dart';
/*
FutureBuilder is used to orchestrate the UI based on the state of the Future (loader → data → error).
 If your query returns 1000 products, Flutter will still have to build them in memory.
What FutureBuilder does is simply:
Display a loader while waiting.
Then replace that loader with the final UI.
we will not see the loading one 5 products is fetcetd it wil get all 5 shown after same 
time if there are 5 or moren then it will get all five shown
check multi state record error loading data ..

*/
class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({
    super.key,
    this.query,
    this.futureMethod,
    required this.title,
  });
  final String title;
  final Future<List<ProductModel>>? futureMethod;
  final Query? query;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      //appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductByQuery(query),
            builder: (context, snpashot) {
              //multiRecordState because we have list of products

              const loader = AppVerticalProductShimmer();
              final widget = AppCloudHelperFunctions.checkMultiRecordState(
                snapshot: snpashot,
                loader: loader,
              );
              if (widget != null) return widget;
              List<ProductModel> products = snpashot.data!;
              return AppSortableProducts(productModel: products);
            },
          ),
        ),
      ),
    );
  }
}
