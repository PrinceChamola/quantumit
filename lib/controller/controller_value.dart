import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerValue extends GetxController {


  Rx<bool> signInValue = false.obs;

  Rx<bool> termsAndConditionsValue = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  updateSignInValue(bool value) {
    signInValue.value = value;
  }

  updateTermsAndConditions(){
    termsAndConditionsValue.value = !termsAndConditionsValue.value;
  }



}