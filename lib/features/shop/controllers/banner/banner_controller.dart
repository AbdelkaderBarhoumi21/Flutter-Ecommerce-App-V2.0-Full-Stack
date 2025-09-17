import 'package:carousel_slider/carousel_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/banner_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  //variables
  final _bannerRepository = Get.put(BannerRepository());
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isBannerLoading = false.obs;

  //variables
  final carouselController = CarouselSliderController();

  RxInt currentIndex = 0.obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  
  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    try {
      //start loading
      isBannerLoading.value = true;
      //fetch all banner 
      List<BannerModel> activeBanners = await _bannerRepository
          .fecthActiveBanners();
      banners.assignAll(activeBanners);
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isBannerLoading.value = false;
    }
  }
}
