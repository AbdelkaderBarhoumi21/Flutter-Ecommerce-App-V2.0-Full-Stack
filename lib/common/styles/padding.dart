import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';

class AppPadding {
  AppPadding._();
  static const EdgeInsetsGeometry screenPadding = EdgeInsets.all(
    AppSizes.defaultSpace,
  );
    static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
  );
}
