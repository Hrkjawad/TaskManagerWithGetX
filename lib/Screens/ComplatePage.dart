import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Datas/Task_Model.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Screens/AddNewTask.dart';
import 'package:TaskManagerWithGetX/Datas/Urls.dart';
import 'package:TaskManagerWithGetX/widgets/EditTasklist.dart';
import 'package:TaskManagerWithGetX/widgets/Tasklist_Item.dart';
import 'package:TaskManagerWithGetX/Datas/SnackbarMessage.dart';
import 'package:TaskManagerWithGetX/widgets/UserProfile.dart';

class ComplatePage extends StatefulWidget {
  const ComplatePage({super.key});

  @override
  State<ComplatePage> createState() => _ComplatePageState();
}

class _ComplatePageState extends State<ComplatePage> {
  TaskModel completedTaskModel = TaskModel();
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    completedNewTasks();
  }

  Future<void> deleteTask(dynamic id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete !'),
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
                    completedNewTasks();
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

  Future<void> completedNewTasks() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(
        'https://task.teamrabbil.com/api/v1/listTaskByStatus/Completed');

    if (response != null) {
      completedTaskModel = TaskModel.fromJson(response);
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
                          completedNewTasks();
                        },
                        child: ListView.builder(
                            itemCount: completedTaskModel.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Tasklist_Item(
                                subject:
                                    completedTaskModel.data?[index].title ??
                                        'Unknown',
                                description: completedTaskModel
                                        .data?[index].description ??
                                    'Unknown',
                                date: completedTaskModel
                                        .data?[index].createdDate ??
                                    'Unknown',
                                type: 'Completed',
                                backgroundColor: Colors.green,
                                onEdit: () {
                                  editTaskList(
                                    'Completed',
                                    completedTaskModel.data?[index].sId ?? '',
                                    () {
                                      completedNewTasks();
                                    },
                                    context,
                                  );
                                },
                                onDelete: () {
                                  deleteTask(
                                      completedTaskModel.data?[index].sId);
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
