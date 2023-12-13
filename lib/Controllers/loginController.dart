import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Datas/auth-utils.dart';
import 'package:TaskManagerWithGetX/Screens/MainPage.dart';

class LoginController extends GetxController {
  RxBool _inProgress = false.obs;

  bool get inProgress => _inProgress.value;
  set inProgress(bool value) => _inProgress.value = value;

  String _message = "";

  String get message => _message;

  Future<void> login(String email, String password) async {
    try {
      inProgress = true;
      _message = '';
      final result = await NetworkUtils().postMethod(
          'https://task.teamrabbil.com/api/v1/login',
          body: {'email': email, 'password': password}, onUnAuthorize: () {
        Get.snackbar(
          'Sorry!',
          'Your Email or Password is incorrect. Please try again!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });

      inProgress = false;
      update();
      if (result != null && result['status'] == 'success') {
        Get.snackbar(
          'Successfully Login!',
          'Please Wait',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await Future.delayed(const Duration(seconds: 3));
        await AuthUtils.saveUserData(
          result['data']['firstName'],
          result['data']['lastName'],
          result['token'],
          result['data']['photo'],
          result['data']['mobile'],
          result['data']['email'],
        );

        Get.to(const MainPage());
      }
    } catch (e) {
      inProgress = false;
      _message = 'An error occurred. Please try again later.';
    }
  }
}
