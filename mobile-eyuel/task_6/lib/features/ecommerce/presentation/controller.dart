import 'package:get/get.dart';

class AuthController extends GetxController {
  final showInputError = false.obs;

  void toggleInputError() {
    showInputError.value = !showInputError.value;
  }
}
