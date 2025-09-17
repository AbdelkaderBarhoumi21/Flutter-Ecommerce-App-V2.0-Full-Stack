import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/authentication_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/data/services/cloudinary_services.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/models/user_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/format_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class UserRepositroy extends GetxController {
  static UserRepositroy get instance => Get.find();

  ///varibales
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  ///function to store user data
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db
          .collection(AppKeys.userCollection)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      //friebase auth exception wrong password used email..
      throw AppFirebaseException(e.code).message;
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

  ///fecth user data from firebase
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection(AppKeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        UserModel user = UserModel.fromSnapshot(documentSnapshot);

        return user;
      }
      return UserModel.empty();
    } on FirebaseAuthException catch (e) {
      //friebase auth exception wrong password used email..
      throw AppFirebaseException(e.code).message;
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

  ///update user data from firebase
  Future<void> updateUserSingleField(Map<String, dynamic> map) async {
    try {
      await _db
          .collection(AppKeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .update(map);
    } on FirebaseAuthException catch (e) {
      //friebase auth exception wrong password used email..
      throw AppFirebaseException(e.code).message;
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

  ///remove user record
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection(AppKeys.userCollection).doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      //friebase auth exception wrong password used email..
      throw AppFirebaseException(e.code).message;
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

  ///upload user profile picture
  Future<dio.Response> uploadImage(File image) async {
    //File image = File('/storage/emulated/0/Download/avatar.png');=> filename:avatar.png

    try {
      dio.Response response = await _cloudinaryServices.uploadImage(
        image,
        AppKeys.profileFolder,
      );
      return response;
    } catch (e) {
      throw 'Failed to upload profile picture. Please try again';
    }
  }

  //function to delete profile picture
  Future<dio.Response> deleteProfilePicture(String publicId) async {
    try {
      dio.Response response = await _cloudinaryServices.deleteImage(
        publicId,
      );
      return response;
    } catch (e) {
      throw 'Something went wrong.Please try again';
    }
  }
}
