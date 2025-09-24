import 'package:ecommerce_application_fullsatck_v2/features/shop/controllers/product/image_controller.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_model.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //variables
  RxMap selectedAttributes = {}.obs; // { "Color": "Blue", "Size": "M" }
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  RxString variationStockStatus = ''.obs;

  //function to select attribute
  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    /*
    Tu ajoutes ou modifies la paire clé/valeur :
    attributeName = "Color"   
    attributeValue = "Blue"
👉 selectedAttributes["Color"] = "Blue" 
    */
    Map<String, dynamic> selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] =
        attributeValue; // selectedAttributes['color']:'green'
    ProductVariationModel selectedVariation = product.productVariations!
        .firstWhere(
          (variation) => isSameAttributeValues(
            variation.attributeValues,
            selectedAttributes,
          ),
          orElse: () => ProductVariationModel.empty(),
        );

    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }
    //assing selected Variation to Rx Variable
    this.selectedVariation(
      selectedVariation,
    ); // the same as this syntax =>this.selectedVariation.value = selectedVariation;
    //check stock status
    getProductVariationStockStatus();
  }

  //check if selected attrributes match any variation attributes
  bool isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    //if selectedselectedAttributes contains 3 attributes and current variation contains 2 then return
    if (variationAttributes.length != selectedAttributes.length) return false;
    //if any of the attributes is different then return ['green','large'] != ['green','small']
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  //check variation stock status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? " In Stock"
        : "Out Of Stock";
  }

  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    //pass the varation to check which attributes are availble and stock is not 0
    final attributesAvailabilityValues = variations
        .where(
          (varation) =>
              varation.attributeValues[attributeName]!.isNotEmpty &&
              varation.attributeValues[attributeName] != null &&
              varation.stock > 0,
        )
        .map((variation) => variation.attributeValues[attributeName])
        .toSet(); //ignore duplciate value with set

    return attributesAvailabilityValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toStringAsFixed(0);
  }
}
