import 'package:get/get.dart';

import '../../personal/controllers/personal_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PersonalController>(() => PersonalController());
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
