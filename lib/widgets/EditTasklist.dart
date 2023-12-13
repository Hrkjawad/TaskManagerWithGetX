import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Datas/SnackbarMessage.dart';
import 'package:TaskManagerWithGetX/Datas/Urls.dart';
import 'package:TaskManagerWithGetX/Screens/MainPage.dart';

class editTaskList extends GetxController {
  editTaskList(String currentStatus, String taskId,
      VoidCallback onChangeTaskStatus, BuildContext context) {
    String statusValue = currentStatus;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, changeState) {
          return Column(
            children: [
              RadioListTile(
                value: 'New',
                title: const Text('New'),
                groupValue: statusValue,
                onChanged: (state) {
                  statusValue = state!;
                  changeState(() {});
                },
              ),
              RadioListTile(
                value: 'Completed',
                title: const Text('Completed'),
                groupValue: statusValue,
                onChanged: (state) {
                  statusValue = state!;
                  changeState(() {});
                },
              ),
              RadioListTile(
                value: 'Cancelled',
                title: const Text('Cancelled'),
                groupValue: statusValue,
                onChanged: (state) {
                  statusValue = state!;
                  changeState(() {});
                },
              ),
              RadioListTile(
                value: 'Progress',
                title: const Text('Progress'),
                groupValue: statusValue,
                onChanged: (state) {
                  statusValue = state!;
                  changeState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: const Text('Change Status'),
                  onPressed: () async {
                    final response = await NetworkUtils()
                        .getMethod(Urls.changeTaskUrl(taskId, statusValue));
                    if (response != null) {
                      onChangeTaskStatus();
                      Get.offAll(const MainPage());
                      Get.snackbar(
                        'Status Changed to:',
                        statusValue,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    } else {
                      SnackBarMessage(
                        Get.context!,
                        'Status change failed. Try again!',
                        true,
                      );
                    }
                  },
                ),
              )
            ],
          );
        });
      },
    );
  }
}
