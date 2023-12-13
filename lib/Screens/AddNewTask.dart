import 'package:TaskManagerWithGetX/Screens/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/widgets/UserProfile.dart';
import 'package:TaskManagerWithGetX/controllers/AddNewTaskController.dart';

class AddNewTask extends StatelessWidget {
  final AddNewTaskController _addNewTaskController =
      Get.put(AddNewTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Obx(
            () => ListView(
              children: [
                const UserProfile(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _addNewTaskController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add New Task',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Add Subject';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Subject',
                              ),
                              controller:
                                  _addNewTaskController.subjectController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Add subject description';
                                }
                                return null;
                              },
                              maxLines: 6,
                              decoration: const InputDecoration(
                                hintText: "Description",
                              ),
                              controller:
                                  _addNewTaskController.descriptionController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (_addNewTaskController.inProgress.value)
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                            else
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                  onPressed: () {
                                    _addNewTaskController.onPressed();
                                    Get.to(const MainPage());
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
