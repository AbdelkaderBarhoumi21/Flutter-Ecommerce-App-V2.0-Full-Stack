import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application_fullsatck_v2/data/services/cloudinary_services.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/brand_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/format_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryService = Get.put(CloudinaryServices());

  //upload all brands
  Future<void> uploadBrands(List<BrandModel> brands) async {
    try {
      for (final brand in brands) {
        //convert asset Pathj to file
        File image = await AppHelperFunctions.assetToFile(brand.image);
        //upload brand image to cloudinary
        dio.Response reponse = await _cloudinaryService.uploadImage(
          image,
          AppKeys.brandsFolder,
        );
        if (reponse.statusCode == 200) {
          brand.image = reponse.data['url'];
        }
        //upload brand model to firestore database
        await _db
            .collection(AppKeys.brandsCollection)
            .doc(brand.id)
            .set(brand.toJson());
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

  //fetch all brands
  Future<List<BrandModel>> fetchBrands() async {
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _db
          .collection(AppKeys.brandsCollection)
          .get();
      if (query.docs.isNotEmpty) {
        List<BrandModel> brands = query.docs
            .map((document) => BrandModel.fromSnapshot(document))
            .toList();

        return brands;
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
