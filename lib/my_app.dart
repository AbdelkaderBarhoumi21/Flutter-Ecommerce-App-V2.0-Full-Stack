import 'package:ecommerce_application_fullsatck_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application_fullsatck_v2/bindings/bindings.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/colors.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/theme/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      getPages: AppRoutes.screens,
      initialBinding:AppBindings() ,
      home: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
