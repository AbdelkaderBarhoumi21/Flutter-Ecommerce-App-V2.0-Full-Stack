import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application_fullsatck_v2/data/services/cloudinary_services.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/category_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/format_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  ///upload category
  Future<void> uploadCategory(List<CategoryModel> categories) async {
    try {
      for (final category in categories) {
        File image = await AppHelperFunctions.assetToFile(category.image);
        dio.Response response = await _cloudinaryServices.uploadImage(
          image,
          AppKeys.categoryFolder,
        );
        if (response.statusCode == 200) {
          category.image = response.data['url'];
        }
        await _db
            .collection(AppKeys.categoryCollection)
            .doc(category.id)
            .set(category.toJson());
        // print('------------------------------------------');
        // print('Category Uploaded:${category.name}');
        // print('------------------------------------------');
      }
    } on FirebaseException catch (e) {
      //more general error like probleme with firebase project not only auth
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (e) {
      //format exception like invalide email
      throw AppFormatException();
    } on AppPlatformException catch (e) {
      //exception related to device like connection probleme ..
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///fetch catgeory fetch list of categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final query = await _db.collection(AppKeys.categoryCollection).get();
      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromSnapshot(document))
            .toList();
        return categories;
      }
      return [];
    } on FirebaseException catch (e) {
      //more general error like probleme with firebase project not only auth
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (e) {
      //format exception like invalide email
      throw AppFormatException();
    } on AppPlatformException catch (e) {
      //exception related to device like connection probleme ..
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
