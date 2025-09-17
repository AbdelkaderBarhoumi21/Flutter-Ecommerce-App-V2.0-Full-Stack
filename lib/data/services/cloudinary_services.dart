import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/api.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';

import 'package:dio/dio.dart' as dio;

class CloudinaryServices extends GetxController {
  static CloudinaryServices get instance => Get.find();
  //variables
  final _dio = dio.Dio();

  ///upload user profile picture
  Future<dio.Response> uploadImage(File image,String folderName) async {
    //File image = File('/storage/emulated/0/Download/avatar.png');=> filename:avatar.png

    try {
      String api = AppApiUrls.uploadApi(AppKeys.cloudName);
      dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': AppKeys.uploadPreset,
        'folder': folderName,
        'file': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });
      dio.Response response = await _dio.post(api, data: formData);
      return response; //return secure url for pciture uploaded
    } catch (e) {
      throw 'Failed to upload profile picture. Please try again';
    }
  }

  //function to delete profile picture
  Future<dio.Response> deleteImage(String publicId) async {
    try {
      /*
      Cloudinary requires a timestamp to prevent signature reuse.
      The string to be signed must contain:
      All parameters sent to Cloudinary (public_id, timestamp)
      Sorted alphabetically
      Then appended to the end of your apiSecret
      example =>public_id=Profile Pictures/avatar123&timestamp=1731817200YOUR_API_SECRET
      */

      String api = AppApiUrls.deleteApi(
        AppKeys.cloudName,
      ); // Endpoint Cloudinary
      int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000)
          .round(); // Construire la string à signer
      String signatureBase =
          'public_id=$publicId&timestamp=$timestamp${AppKeys.apiSecret}'; // Générer signature SHA1
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();
      final dio.FormData formData = dio.FormData.fromMap({
        'public_id': publicId,
        'api_key': AppKeys.apiKey,
        'timestamp': timestamp,
        'signature': signature,
      }); // Construire formData
      dio.Response response = await _dio.post(
        api,
        data: formData,
      ); // Envoyer la requête

      return response;
    } catch (e) {
      throw 'Something went wrong.Please try again';
    }
  }
}
