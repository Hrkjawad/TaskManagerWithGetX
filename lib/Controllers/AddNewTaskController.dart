import 'package:TaskManagerWithGetX/Screens/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Datas/NetUtils.dart';
import '../Datas/SnackbarMessage.dart';

class AddNewTaskController extends GetxController {
  final RxBool inProgress = false.obs;
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void onPressed() async {
    if (formKey.currentState!.validate()) {
      inProgress.value = true;
      update();
      final result = await NetworkUtils().postMethod(
        'https://task.teamrabbil.com/api/v1/createTask',
        body: {
          "title": subjectController.text.trim(),
          "description": descriptionController.text.trim(),
          "status": "New"
        },
      );
      inProgress.value = false;
      update();
      if (result != null && result['status'] == 'success') {
        subjectController.clear();
        descriptionController.clear();
        SnackBarMessage(Get.context!, 'Task added successfully!');
        update();
        Get.to(const MainPage());
      } else {
        SnackBarMessage(Get.context!, 'Task adding failed! Try again', true);
      }
    }
  }
}
