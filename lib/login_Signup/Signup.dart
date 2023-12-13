import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Screens/bg.dart';
import 'package:TaskManagerWithGetX/login_Signup/login.dart';
import 'package:TaskManagerWithGetX/controllers/signupController.dart';

class Signup extends StatelessWidget {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SignupController _signupController = Get.put(SignupController());

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
                    height: 30,
                  ),
                  Text(
                    "Join With Us",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.name,
                    controller: firstNameTextController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "First Name",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.name,
                    controller: lastNameTextController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter last name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Last Name",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    controller: mobileTextController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Mobile number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Mobile Number",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordTextController,
                    validator: (value) {
                      if ((value?.isEmpty ?? true) &&
                          (value?.length ?? 0) < 6) {
                        return 'Please Enter your password more than 6 letters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                        child: _signupController.inProgress
                            ? CircularProgressIndicator()
                            : const Icon(Icons.arrow_circle_right_outlined),
                        onPressed: () async {
                          if (!_signupController.inProgress &&
                              formKey.currentState!.validate()) {
                            _signupController.signup(
                              email: emailTextController.text,
                              firstName: firstNameTextController.text,
                              lastName: lastNameTextController.text,
                              mobile: mobileTextController.text,
                              password: passwordTextController.text,
                            );
                          }
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(const login());
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
