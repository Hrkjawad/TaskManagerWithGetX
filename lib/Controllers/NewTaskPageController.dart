import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Datas/Task_Model.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Datas/SnackbarMessage.dart';
import 'package:TaskManagerWithGetX/Datas/Urls.dart';

class NewTaskPageController extends GetxController {
  final newTaskModel = TaskModel().obs;
  final inProgress = false.obs;
  final newTasksCount = '0'.obs;
  final completedCount = '0'.obs;
  final canceledCount = '0'.obs;
  final progressCount = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    getNewTasks();
    statusCount();
  }

  Future<void> deleteTask(dynamic id) async {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete!'),
        content: const Text("Once delete, you won't be able to get it back"),
        actions: [
          OutlinedButton(
            onPressed: () async {
              Get.back();
              inProgress.value = true;
              await NetworkUtils().deleteMethod(Urls.deleteTaskUrl(id));
              inProgress.value = false;
              getNewTasks();
              statusCount();
            },
            child: const Text('Yes'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  Future<void> getNewTasks() async {
    inProgress.value = true;
    final response = await NetworkUtils()
        .getMethod('https://task.teamrabbil.com/api/v1/listTaskByStatus/New');

    if (response != null) {
      newTaskModel.value = TaskModel.fromJson(response);
    } else {
      SnackBarMessage(Get.context!, 'Unable to fetch data. Try again!', true);
    }
    inProgress.value = false;
  }

  Future<void> statusCount() async {
    final responseNewTask = await NetworkUtils()
        .getMethod('https://task.teamrabbil.com/api/v1/listTaskByStatus/New');
    final getNewTaskModel = TaskModel.fromJson(responseNewTask);

    newTasksCount.value = "${getNewTaskModel.data?.length ?? 0}";

    final responseCancelTask = await NetworkUtils().getMethod(
        'https://task.teamrabbil.com/api/v1/listTaskByStatus/Cancelled');
    final getCanceledTaskModel = TaskModel.fromJson(responseCancelTask);
    canceledCount.value = "${getCanceledTaskModel.data?.length ?? 0}";

    final responseCompletedTask = await NetworkUtils().getMethod(
        'https://task.teamrabbil.com/api/v1/listTaskByStatus/Completed');
    final getCompletedTaskModel = TaskModel.fromJson(responseCompletedTask);
    completedCount.value = "${getCompletedTaskModel.data?.length ?? 0}";

    final responseProgressTask = await NetworkUtils().getMethod(
        'https://task.teamrabbil.com/api/v1/listTaskByStatus/Progress');
    final getProgressTaskModel = TaskModel.fromJson(responseProgressTask);
    progressCount.value = "${getProgressTaskModel.data?.length ?? 0}";
  }
}
