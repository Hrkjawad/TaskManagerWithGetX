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

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  TaskModel inProgressTaskModel = TaskModel();
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    inProgressTasks();
  }

  Future<void> deleteTask(dynamic id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete !'),
            content: const Text("Once delete, you won't be get it back"),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Get.back();
                    inProgress = true;
                    setState(() {});
                    await NetworkUtils().deleteMethod(Urls.deleteTaskUrl(id));
                    inProgress = false;
                    setState(() {});
                    inProgressTasks();
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

  Future<void> inProgressTasks() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(
        'https://task.teamrabbil.com/api/v1/listTaskByStatus/Progress');

    if (response != null) {
      inProgressTaskModel = TaskModel.fromJson(response);
    } else {
      if (mounted) {
        SnackBarMessage(context, 'Unable to fetch the data. Try again!', true);
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
                          inProgressTasks();
                        },
                        child: ListView.builder(
                            itemCount: inProgressTaskModel.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Tasklist_Item(
                                subject:
                                    inProgressTaskModel.data?[index].title ??
                                        'Unknown',
                                description: inProgressTaskModel
                                        .data?[index].description ??
                                    'Unknown',
                                date: inProgressTaskModel
                                        .data?[index].createdDate ??
                                    'Unknown',
                                type: 'Progress',
                                backgroundColor: Colors.purple,
                                onEdit: () {
                                  editTaskList(
                                    'Progress',
                                    inProgressTaskModel.data?[index].sId ?? '',
                                    () {
                                      inProgressTasks();
                                    },
                                    context,
                                  );
                                },
                                onDelete: () {
                                  deleteTask(
                                      inProgressTaskModel.data?[index].sId);
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
