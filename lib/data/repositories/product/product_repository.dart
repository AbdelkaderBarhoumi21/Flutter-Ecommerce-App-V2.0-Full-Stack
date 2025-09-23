import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application_fullsatck_v2/data/services/cloudinary_services.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/format_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  //! function to upload list of products to firebase
  Future<void> uploadProducts(List<ProductModel> products) async {
    try {
      for (ProductModel product in products) {
        //convert assetpath to file
        File thumbnail = await AppHelperFunctions.assetToFile(
          product.thumbnail,
        );
        //upload product to cloudinary

        dio.Response response = await _cloudinaryServices.uploadImage(
          thumbnail,
          AppKeys.productsFolder,
        );
        if (response.statusCode == 200) {
          product.thumbnail = response.data['url'];
        }
        //upload product images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (String image in product.images!) {
            File imageFile = await AppHelperFunctions.assetToFile(image);
            //upload product to cloudinary

            dio.Response response = await _cloudinaryServices.uploadImage(
              imageFile,
              AppKeys.productsFolder,
            );
            if (response.statusCode == 200) {
              imagesUrl.add(response.data['url']);
            }
          }
          //upadte product variation imgaes
          if (product.productVariations != null &&
              product.productVariations!.isNotEmpty) {
            for (final variation in product.productVariations!) {
              int index = product.images!.indexWhere(
                (image) => image == variation.image,
              );
              variation.image = imagesUrl[index];
            }
          }

          //assign image url to product
          product.images!
            ..clear()
            ..assignAll(imagesUrl);
          // product.images!.clear(); //clear the assethpath
          // product.images!.assignAll(imagesUrl);
        }
        //upload product to firebase firestore
        await _db
            .collection(AppKeys.productsCollection)
            .doc(product.id)
            .set(product.toJson());
        print('Product : ${product.id} uploaded');
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

  //! function to fecth list of products from firebase
  Future<List<ProductModel>> fetchFeatureProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _db
          .collection(AppKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();
      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
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
