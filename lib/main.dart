import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Screens/OpeningScreen.dart';
import 'package:TaskManagerWithGetX/Controllers/loginController.dart';
import 'package:TaskManagerWithGetX/Controllers/AddNewTaskController.dart';
import 'Controllers/NewTaskPageController.dart';
import 'Controllers/signupController.dart';

void main() {
  runApp(const TaskManager());
}

class TaskManager extends StatefulWidget {
  const TaskManager({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const OpeningScreen(),
    );
  }
}

class controllerBuilder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SignupController());
    Get.put(AddNewTaskController());
    Get.put(NewTaskPageController());
  }
}
