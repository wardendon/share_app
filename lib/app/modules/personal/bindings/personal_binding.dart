import 'package:get/get.dart';

import 'package:share_app/app/modules/personal/controllers/contribute_controller.dart';

import '../controllers/personal_controller.dart';

class PersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContributeController>(
      () => ContributeController(),
    );
    Get.lazyPut<PersonalController>(
      () => PersonalController(),
    );
  }
}
