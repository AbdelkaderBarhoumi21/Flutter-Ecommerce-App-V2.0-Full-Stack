import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/signup/signup.dart';
import 'package:ecommerce_application_fullsatck_v2/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/address/address_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/edit_profile/edit_profile_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/personalization/screens/profile/profile_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/cart/cart_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/checkout/checkout_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/order/order_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/store/store_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/screens/whishlist/whishlist_screen.dart';
import 'package:ecommerce_application_fullsatck_v2/navigation_menu.dart';
import 'package:ecommerce_application_fullsatck_v2/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes{
  static final screens=[
    GetPage(name: Routes.home, page: () => const NavigationMenu()),
    GetPage(name: Routes.store, page: () => const StoreScreen(),),
    GetPage(name: Routes.wishlist, page: () => const WhishlistScreen(),),
    GetPage(name: Routes.profile, page: () => const ProfileScreen(),),
    GetPage(name: Routes.order, page: () => const OrderScreen(),),
    GetPage(name: Routes.checkout, page: () => const CheckoutScreen(),),
    GetPage(name: Routes.cart, page: () => const CartScreen(),),
    GetPage(name: Routes.editProfile, page: () => const EditProfileScreen(),),
    GetPage(name: Routes.userAddress, page: () => const UserAddressScreen(),),
    GetPage(name: Routes.signup, page: () => const SignupScreen(),),
    GetPage(name: Routes.verifyEmail, page: () => const VerifyEmailScreen(),),
    GetPage(name: Routes.signIn, page: () => const LoginScreen(),),
    GetPage(name: Routes.forgetPassword, page: () => const ForgetPasswordScreen(),),
    GetPage(name: Routes.onBoarding, page: () => const OnboardingScreen(),),
  ];

}