import 'package:ecommerce_application_fullsatck_v2/data/repositories/user/user_repositroy.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/navigation_menu.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/helpers/network_manager.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();

  //!variables
  final _userController = UserController.instance;
  final _userRepository = UserRepositroy.instance;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final updateFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    intializeNames();
    super.onInit();
  }

  void intializeNames() {
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;
  }

  //update username
  Future<void> updateUserName() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
      );
      //check internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        AppSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }
      //form validation
      if (!updateFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }
      //update name from firestore
      Map<String, dynamic> map = {
        'FirstName': firstName.text.trim(),
        'Lastname': lastName.text.trim(),
      };
      await _userRepository.updateUserSingleField(map);
      //update user from rx user
      _userController.user.value.firstName = firstName.text;
      _userController.user.value.firstName = lastName.text;
      //stop loading
      AppFullScreenLoader.stopLoading();
      //move to previous screen
      Get.offAll(() => NavigationMenu());
      //success snack bar
      AppSnackBarHelpers.successSnackBar(
        title: 'Congratulations',
        message: 'Your name has been updated',
      );
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackBarHelpers.errorSnackBar(
        title: 'Update Name Failed!',
        message: e.toString(),
      );
      print(e);
    }
  }
}
