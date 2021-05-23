import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sample_project/helpers/auth_helpers.dart';
import 'package:sample_project/models/user_model.dart';
import 'package:sample_project/screens/home_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  AuthHelpers authHelpers = AuthHelpers();
  var userModel = UserModel().obs;

  login(String email, String password) async {
    isLoading.value = true;
    String response = await authHelpers.login(email, password);
    if (response != null) {
      Get.snackbar(response, '');
      isLoading.value = false;
    } else {
      Get.offAll(HomeScreen());
      isLoading.value = false;
    }
  }

  signUp(UserModel userModel, String password, File profilePic) async {
    isLoading.value = true;
    String response = await authHelpers.signUp(userModel, password, profilePic);
    if (response != null) {
      Get.snackbar(response, '');
      isLoading.value = false;
    } else {
      Get.offAll(HomeScreen());
      isLoading.value = false;
    }
  }
}
