import 'package:ecommerce_application_fullsatck_v2/data/repositories/category/category_repository.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/category_model.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  //varaibles
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  //feature categoires => category we want to show it first
  RxList<CategoryModel> feautredCategories = <CategoryModel>[].obs;

  RxBool isCategoriesLoading = false.obs;

  @override
  void onInit() {
    fecthCategories();
    super.onInit();
  }

  //function tp fetch all categoirs and feature categories from firebase
  Future<void> fecthCategories() async {
    try {
      //loading
      isCategoriesLoading.value = true;
      //fecth catgeoires
      List<CategoryModel> categories = await _categoryRepository
          .getAllCategories();
      allCategories.assignAll(categories);
      //fetch feautres categories
      feautredCategories.assignAll(
        categories.where(
          (category) => category.isFeatured && category.parentId.isEmpty,
        ),
      );
    } catch (e) {
      AppSnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isCategoriesLoading.value = false;
    }
  }
}
