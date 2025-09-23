import 'package:ecommerce_application_fullsatck_v2/data/dummy_data.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/product/product_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/user/user_repositroy.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/format_exception.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  //static → only one global copy exists for the entire class.
  static AuthenticationRepository get instance => Get.find();
  //variables
  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  @override
  void onReady() {
    //remove the splash screen
    FlutterNativeSplash.remove();
    //redirect to the right screen
    screenRedirect();

    // //!add category reposirtoy to delete later and add to admin app to upload category to firebase and cloudinary
    // Get.put(CategoryRepository()).uploadCategory(AppDummyModel.categories);
    // //!add banner reposirtoy to delete later and add to admin app to upload banner to firebase and cloudinary
    // Get.put(BannerRepository()).uploadBanners(AppDummyModel.banner);
    // //!add brand reposirtoy to delete later and add to admin app to upload brand to firebase and cloudinary
    // Get.put(BrandRepository()).uploadBrands(AppDummyModel.brands);
    // //!add product reposirtoy to delete later and add to admin app to upload product to firebase and cloudinary
    // Get.put(ProductRepository()).uploadProducts(AppDummyModel.products);

    super.onReady();
  }

  void screenRedirect() {
    final user = _auth.currentUser;
    //check if user is verified
    if (user != null) {
      //if verified go to naviagtion menu
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu());
      } else {
        //if not verified
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      //write is fristtime if null
      localStorage.writeIfNull('isFirstTime', true);
      //check if user is first time
      localStorage.read("isFirstTime") == true
          ? Get.to(() => OnboardingScreen())
          : Get.to(() => LoginScreen());
    }
  }

  ///authentication with email and password
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      //usercredential return user object(profile firebase) like uuid email dispplayname
      //additionalUserInfo like isNeweruser providerId provider type (password,google,facerbokk)
      //or crendetial info d'identifcation token oAuth if connected via google
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
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

  //! email verification send email
  Future<void> sendEmailVerificatuion() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
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

  //sign in with email and password
  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
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

  //! google sign
  Future<UserCredential?> loginWithGoogle() async {
    try {
      // Required async initialization
      await GoogleSignIn.instance.initialize();
      // 1) Let user pick a Google account //authenticate replace SignIn
      final GoogleSignInAccount? account = await GoogleSignIn.instance
          .authenticate();

      // 2) Get Google tokens
      final GoogleSignInAuthentication? googleAuth = account?.authentication;

      // 3) Build Firebase credential (NOTE: idToken, not id)
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
      );

      // 4) Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      // Optional: debug
      debugPrint('UID: ${userCredential.user?.uid}');
      debugPrint('Email: ${userCredential.user?.email}');

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException {
      throw AppFormatException();
    } on AppPlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //forget password send email to reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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

  //logout logout the user
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.signOut();
      Get.offAll(() => LoginScreen());
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

  //sign in with email and password
  Future<void> reAuthenticateUserWithEmailAndPassowrd(
    String email,
    String password,
  ) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser!.reauthenticateWithCredential(credential);
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

  //delete user account
  Future<void> deleteAccount() async {
    try {
      //remove user record from firestore database
      await UserRepositroy.instance.removeUserRecord(currentUser!.uid);

      //Remove profile Picture from cloudinary
      String publicId = UserController.instance.user.value.publicId;
      if (publicId.isNotEmpty) {
        UserRepositroy.instance.deleteProfilePicture(publicId);
      }
      //remove user provider from authentrication
      await _auth.currentUser?.delete();
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
}
