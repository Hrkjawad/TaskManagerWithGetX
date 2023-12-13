import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Screens/bg.dart';
import 'package:TaskManagerWithGetX/Screens/ForgotPassEmail.dart';
import 'package:TaskManagerWithGetX/login_Signup/Signup.dart';
import 'package:TaskManagerWithGetX/Controllers/loginController.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());

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
                    height: 40,
                  ),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordTextController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your valid password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_loginController.inProgress)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    ElevatedButton(
                      child: const Icon(Icons.arrow_circle_right_outlined),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          _loginController.login(
                            emailTextController.text,
                            passwordTextController.text,
                          );
                        }
                      },
                    ),
                  TextButton(
                    onPressed: () {
                      Get.to( ForgotPassEmail());
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(Signup());
                        },
                        child: const Text("Sign Up"),
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
