import 'package:ecommerce_application_fullsatck_v2/data/repositories/brand/brand_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/data/repositories/product/product_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/brand_model.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featureBrands = <BrandModel>[].obs;
  RxBool isBrandLoading = false.obs;

  //variables
  final _brandRepository = Get.put(BrandRepository());
  final _productRepository = ProductRepository.instance;

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void> getBrands() async {
    try {
      //start loading
      isBrandLoading.value = true;
      //fecth all brands
      List<BrandModel> allBrands = await _brandRepository.fetchBrands();
      this.allBrands.assignAll(allBrands);
      //filter feature brand
      featureBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).toList(),
      );
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isBrandLoading.value = false;
    }
  }

  //get brand specific Products
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      List<ProductModel> products = await _productRepository
          .getProductsForBrand(brandId: brandId);
      return products;
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }
}
