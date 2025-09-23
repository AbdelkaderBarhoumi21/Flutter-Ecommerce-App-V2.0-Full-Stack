import 'package:ecommerce_application_fullsatck_v2/data/repositories/product/product_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/enums.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/texts.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  //variables
  final _repository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getFeautredProduct();
    super.onInit();
  }

  //function to get ony 4 feature products

  Future<void> getFeautredProduct() async {
    try {
      isLoading.value = true;
      //fetch feature products
      List<ProductModel> featuredProducts = await _repository
          .fetchFeatureProducts();
      //assign feature products
      this.featuredProducts.assignAll(featuredProducts);
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  //calculate sale percentage
  String? calculateSalePercantage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(
      0,
    ); //to dont get perctnage like 3.3333 we only get 3
  }
  //get product price or price range for a varibale 
  String getProductPrice(ProductModel product) {
    double samllestprice = double.infinity; //démarre à infinity et descend.
    double largestPrice = 0.0; //largestPrice démarre à 0 et monte.

    if (product.productType == ProductType.single.toString()) {
      //ProductType.single.toString() == 'ProductType.single' in the firebase
      return product.salePrice > 0
          ? product.salePrice.toString()
          : product.price.toString();
    } else {
      //calculate the largest and smallest price among variation
      for (final variantion in product.productVariations!) {
        double variationPrice = variantion.salePrice > 0
            ? variantion.salePrice
            : variantion.price;

        if (variationPrice > largestPrice) {
          largestPrice = variationPrice;
        }
        if (variationPrice < samllestprice) {
          samllestprice = variationPrice;
        }
      }

      if (samllestprice.isEqual(largestPrice)) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${largestPrice.toStringAsFixed(0)}-${AppTexts.currency}${samllestprice.toStringAsFixed(0)}';
      }
    }
  }
}
