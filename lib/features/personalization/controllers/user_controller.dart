import 'dart:io';

import 'package:ecommerce_application_fullsatck_v2/data/repositories/authentication_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/user/user_repositroy.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/models/user_model.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/edit_profile/widgets/user_reauthenticate_form.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/api.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/keys.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/sizes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/network_manager.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  ///variables
  final _userRepository = Get.put(UserRepositroy());
  final authRepository = AuthenticationRepository.instance;

  //reuathenticate form variables
  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool isProfileUploading = false.obs;
  void showPassowrd() {
    isPasswordVisible.value = isPasswordVisible.value == true ? false : true;
  }

  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;

  @override
  void onInit() {
    fecthUserDetails();

    super.onInit();
  }

  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
      //first update Rx varibale and then check if user data is already stored if not then store
      await fecthUserDetails();
      if (user.value.id.isEmpty) {
        //convert full to first name and last  name
        final nameParts = UserModel.nameParts(userCredential.user!.displayName);
        final username = '${userCredential.user!.displayName}23176';
        //create user model
        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredential.user!.email ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          profilePicture: userCredential.user!.photoURL ?? '',
        );
        //save user record
        await _userRepository.saveUserRecord(userModel);
      }
    } catch (e) {
      AppSnackBarHelpers.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information',
      );
      print(e);
    }
  }

  Future<void> fecthUserDetails() async {
    try {
      profileLoading.value = true;
      UserModel user = await _userRepository.fetchUserDetails();
      //Get
      this.user(user); // == this.user.value = user;
    } catch (e) {
      user(UserModel.empty());
      print(e);
    } finally {
      profileLoading.value = false;
    }
  }

  //popup to delete account confirmation
  void deleteAccoountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(AppSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete account permanetly?',
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Text('Delete'),
        ),
      ),
    );
  }

  // delete account
  Future<void> deleteUserAccount() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog('Processing...');
      //Re-Authenticate user
      //provider mean what we use for auth email/password facebook google provider for auth
      //retrun list of userInfor
      final provider = authRepository.currentUser!.providerData
          .map((e) => e.providerId)
          .first;
      if (provider == "google.com") {
        authRepository.loginWithGoogle();
        authRepository.deleteAccount();
        AppFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());
      } else if (provider == 'password') {
        AppFullScreenLoader.stopLoading();
        Get.to(() => ReAuthenticateUserForm());
      }
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      print(e);
    }
  }

  //reauthenticated user with email and password

  Future<void> reAuthenticateUSer() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog('Logging you in....');
      //cehck internet connectivity
      final isconnected = await NetworkManager.instance.isConnected();
      if (!isconnected) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      //check formsate validation
      if (!reAuthFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      //reauthenticate user with email and passowrd
      await authRepository.reAuthenticateUserWithEmailAndPassowrd(
        email.text.trim(),
        password.text.trim(),
      );
      //delete account
      await authRepository.deleteAccount();
      //stop loading
      AppFullScreenLoader.stopLoading();
      //Redirect
      Get.offAll(() => LoginScreen());
    } catch (e) {
      //stop loading
      AppFullScreenLoader.stopLoading();
      AppSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      print(e);
    }
  }

  Future<void> updateUserProfilePicture() async {
    try {
      //start loading
      isProfileUploading.value = true;
      //Pick Image From gallery
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image == null) {
        return;
      }
      //convert Xfile to file
      File file = File(image.path);
      //delete user current profile pîcture
      if (user.value.publicId.isNotEmpty) {
        _userRepository.deleteProfilePicture(user.value.publicId);
      }
      //upload profile picture
      dio.Response response = await _userRepository.uploadImage(file);
      if (response.statusCode == 200) {
        //Get Data
        //when you upload a picture to Cloudinary (via their REST API), the response is standardized.inside response you can find url public_id asset_id folder...

        final data = response.data;
        final imageUrl = data['url'];
        final publicId =
            data['public_id']; //id of pciture to be used to delete image if delte account from firebase
        //update profile picture from fireStore
        _userRepository.updateUserSingleField({
          'ProfilePicture': imageUrl,
          'publicId': publicId,
        });
        //update profile picture and public id from rx user
        user.value.profilePicture = imageUrl;
        user.value.publicId = publicId;
        user.refresh();
        //success Messgae
        AppSnackBarHelpers.successSnackBar(
          title: 'Congratulation',
          message: 'Profile picture updated successfully',
        );
      } else {
        throw 'Failed to upload picture. Please try again';
      }
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }finally{
           //start loading
      isProfileUploading.value = false;
    }
  }
}
