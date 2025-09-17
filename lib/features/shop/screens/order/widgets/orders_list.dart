import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class AppOrdersListItems extends StatelessWidget {
  const AppOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return ListView.separated(
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSizes.spaceBtwItems),
      itemCount: 3,
      itemBuilder: (context, index) {
        return AppRoundedContainer(
          showBorder: true,
          backgroundColor: dark ? AppColors.dark : AppColors.light,
          padding: EdgeInsets.all(AppSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //1- row
              Row(
                children: [
                  //ship icon
                  Icon(Iconsax.ship),
                  SizedBox(width: AppSizes.spaceBtwItems / 2),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title
                        Text(
                          "Processing",
                          style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: AppColors.primary,
                            fontWeightDelta: 1,
                          ),
                        ),
                        Text(
                          "01 Jan 2025",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.arrow_right_34, size: AppSizes.iconSm),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //2nd Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Icon(Iconsax.tag),
                        SizedBox(width: AppSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "GYS324",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Icon(Iconsax.calendar),
                        SizedBox(width: AppSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shipping Date",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "06 Jan 2025",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
