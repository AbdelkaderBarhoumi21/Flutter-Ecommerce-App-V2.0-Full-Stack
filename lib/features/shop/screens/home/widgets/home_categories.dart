import 'package:ecommerce_application_fullsatck_v2/common/widget/shimmer/category_shimmer.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/image_text/vertical_image_text.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/sub_category/sub_category_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:get/get.dart';

class AppHomeCategories extends StatelessWidget {
  const AppHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Home catgeoires
          Text(
            AppTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: AppColors.white),
          ),
          SizedBox(height: AppSizes.spaceBtwItems),
          //categoires listview
          Obx(() {
            final categories = controller.feautredCategories;
            //loading state
            if (controller.isCategoriesLoading.value) {
              return AppCategoryShimmer(itemCount: 6);
            }
            //empty state
            if (categories.isEmpty) {
              return Text('Categories Not Found');
            }
            // data found
            return SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: AppSizes.spaceBtwItems),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  CategoryModel Category = categories[index];
                  return AppVerticalImageText(
                    title: Category.name,
                    image: Category.image,
                    textColor: AppColors.white,
                    onTap: () => Get.to(() => SubCategoryScreen()),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
