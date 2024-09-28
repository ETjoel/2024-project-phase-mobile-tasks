import 'package:get/get.dart';

class AuthController extends GetxController {
  final showInputError = false.obs;
  final checkboxChecked = false.obs;
  final checkboxError = false.obs;
  final doesConfirmPasswordMatch = true.obs;

  void toggleCheckbox() {
    checkboxChecked.value = !checkboxChecked.value;
  }

  void toggleConfirmPasswordMatch() {
    doesConfirmPasswordMatch.value = false;
  }

  void toggleInputError() {
    showInputError.value = true;
  }

  void toggleCheckboxError() {
    checkboxError.value = true;
  }
}
