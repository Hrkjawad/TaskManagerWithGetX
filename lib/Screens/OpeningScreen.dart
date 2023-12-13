import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Screens/bg.dart';
import 'package:TaskManagerWithGetX/login_Signup/login.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {

  void initState(){
    super.initState();
    GoLogin();
  }

  void GoLogin() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
     Get.offAll(const login());});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        child:
          Center(
            child:
            SvgPicture.asset(
              'assets/logo.svg',
            ),
          ),
      )
    );
  }
}
