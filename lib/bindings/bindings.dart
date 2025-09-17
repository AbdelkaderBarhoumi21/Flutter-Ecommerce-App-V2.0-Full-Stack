import 'package:ecommerce_application_fullsatck_v2/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
