import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Screens/bg.dart';
import 'package:TaskManagerWithGetX/login_Signup/login.dart';
import 'package:TaskManagerWithGetX/Screens/ForgotPassPinVerification.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Datas/SnackbarMessage.dart';
import 'package:TaskManagerWithGetX/Datas/Urls.dart';

class ForgotPassEmail extends GetView {
  final RxBool inProgress = false.obs;
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Text(
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "A 6 digit verification pin will send to your email address",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    obscureText: false,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    if (inProgress.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        child: const Icon(Icons.arrow_circle_right_outlined),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            inProgress.value = true;
                            final response = await NetworkUtils().getMethod(
                              Urls.recoveryEmailUrl(
                                emailController.text.trim(),
                              ),
                            );
                            if (response != null &&
                                response['status'] == 'success') {
                              SnackBarMessage(
                                Get.context!,
                                'OTP sent to email address',
                              );
                              Get.to(
                                () => ForgotPassPinVerification(),
                                arguments: {
                                  'email': emailController.text.trim()
                                },
                              );
                            } else {
                              SnackBarMessage(
                                Get.context!,
                                'OTP sent failed. Try again!',
                                true,
                              );
                            }
                            inProgress.value = false;
                          }
                        },
                      );
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const login());
                        },
                        child: const Text("Sign in"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
