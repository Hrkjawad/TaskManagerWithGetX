import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Datas/Task_Model.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Screens/AddNewTask.dart';
import 'package:TaskManagerWithGetX/Datas/Urls.dart';
import 'package:TaskManagerWithGetX/widgets/Tasklist_Item.dart';
import 'package:TaskManagerWithGetX/Datas/SnackbarMessage.dart';
import 'package:TaskManagerWithGetX/widgets/UserProfile.dart';
import 'package:TaskManagerWithGetX/widgets/EditTasklist.dart';

class CanceledPage extends StatefulWidget {
  const CanceledPage({super.key});

  @override
  State<CanceledPage> createState() => _CanceledPageState();
}

class _CanceledPageState extends State<CanceledPage> {
  TaskModel cancelledTaskModel = TaskModel();
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    cancelTasks();
  }

  Future<void> deleteTask(dynamic id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete!'),
            content:
                const Text("Warning! Once delete, you won't be get it back"),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Get.back();
                    inProgress = true;
                    setState(() {});
                    await NetworkUtils().deleteMethod(Urls.deleteTaskUrl(id));
                    inProgress = false;
                    setState(() {});
                    cancelTasks();
                  },
                  child: const Text('Yes')),
              OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('No')),
            ],
          );
        });
  }

  Future<void> cancelTasks() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(
        'https://task.teamrabbil.com/api/v1/listTaskByStatus/Cancelled');

    if (response != null) {
      cancelledTaskModel = TaskModel.fromJson(response);
    } else {
      if (mounted) {
        SnackBarMessage(context, 'Unable to fetch data. Try again!', true);
      }
    }
    inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfile(),
            Expanded(
                child: inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          cancelTasks();
                        },
                        child: ListView.builder(
                            itemCount: cancelledTaskModel.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Tasklist_Item(
                                subject:
                                    cancelledTaskModel.data?[index].title ??
                                        'Unknown',
                                description: cancelledTaskModel
                                        .data?[index].description ??
                                    'Unknown',
                                date: cancelledTaskModel
                                        .data?[index].createdDate ??
                                    'Unknown',
                                type: 'Cancelled',
                                backgroundColor: Colors.redAccent,
                                onEdit: () {
                                  editTaskList(
                                    'Completed',
                                    cancelledTaskModel.data?[index].sId ?? '',
                                    () {
                                      cancelTasks();
                                    },
                                    context,
                                  );
                                },
                                onDelete: () {
                                  deleteTask(
                                      cancelledTaskModel.data?[index].sId);
                                },
                              );
                            }),
                      )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Get.to( AddNewTask());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
