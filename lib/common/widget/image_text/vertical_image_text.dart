import 'package:ecommerce_application_fullsatck_v2/common/widget/images/circular_images.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/common/widget/custom_shapes/circular_container.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';

class AppVerticalImageText extends StatelessWidget {
  const AppVerticalImageText({
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
    super.key,
  });

  final String title;
  final String image;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          //circular images
          AppCircularImage(
            image: image,
            height: 56,
            width: 56,
            isNetworkImage: true,
          ),

          SizedBox(height: AppSizes.spaceBtwItems / 2),
          //title
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: textColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
