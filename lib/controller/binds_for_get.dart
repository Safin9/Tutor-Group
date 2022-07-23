import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
  }
}
