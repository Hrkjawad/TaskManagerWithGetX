import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Datas/SnackbarMessage.dart';
import 'package:TaskManagerWithGetX/login_Signup/login.dart';

class SignupController extends GetxController {
  RxBool _inProgress = false.obs;

  bool get inProgress => _inProgress.value;
  set inProgress(bool value) => _inProgress.value = value;

  Future<void> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    try {
      inProgress = true;
      update();

      final result = await NetworkUtils().postMethod(
        'https://task.teamrabbil.com/api/v1/registration',
        body: {
          'email': email.trim(),
          'mobile': mobile.trim(),
          'password': password,
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
        },
      );

      inProgress = false;
      update();

      if (result != null && result['status'] == 'success') {

        SnackBarMessage(Get.context!, 'Your Registration is Successful !');
        Get.to(const login());
      } else {
        SnackBarMessage(Get.context!, 'Registration Failed !', true);
      }
    } catch (e) {
      inProgress = false;
      update();
      SnackBarMessage(Get.context!, 'An error occurred. Please try again later.');
    }
  }
}
