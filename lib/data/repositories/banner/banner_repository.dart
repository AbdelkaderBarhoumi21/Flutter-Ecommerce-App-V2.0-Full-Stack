import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application_fullsatck_v2/data/services/cloudinary_services.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/banner_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/format_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryService = Get.put(CloudinaryServices());
  //function to upload banner
  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      for (final banner in banners) {
        //convert assetPath image to File
        File image = await AppHelperFunctions.assetToFile(banner.imageUrl);
        //upload cloudinary image url
        dio.Response response = await _cloudinaryService.uploadImage(
          image,
          AppKeys.bannersFolder,
        );
        if (response.statusCode == 200) {
          banner.imageUrl = response.data['url'];
        }
        //upload to firebase
        await _db
            .collection(AppKeys.bannerCollection)
            .doc()
            .set(
              banner.toJson(),
            ); //for id if we dont pass in doc it will auto generate
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

  //function to fetch list of active banner
  Future<List<BannerModel>> fecthActiveBanners() async {
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _db
          .collection(AppKeys.bannerCollection).where('active',isEqualTo: true)
          .get(); //query type => QuerySnapshot<Map<String, dynamic>> query
      if (query.docs.isNotEmpty) {
        List<BannerModel> banners = query.docs
            .map((document) => BannerModel.fromDocument(document))
            .toList();

        return banners;
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
