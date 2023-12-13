import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TaskManagerWithGetX/Screens/SetPassword.dart';
import 'package:TaskManagerWithGetX/Screens/bg.dart';
import 'package:TaskManagerWithGetX/login_Signup/login.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:TaskManagerWithGetX/Datas/NetUtils.dart';
import 'package:TaskManagerWithGetX/Datas/SnackbarMessage.dart';
import 'package:TaskManagerWithGetX/Datas/Urls.dart';

class ForgotPassPinVerification extends GetView {
  final TextEditingController otpController = TextEditingController();
  final RxBool isButtonEnabled = false.obs;
  late String email;

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    email = arguments['email'] as String? ?? '';

    return Scaffold(
      body: background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 55,
                ),
                Text(
                  "PIN Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "A 6 digit verification pin will be sent to your email address",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PinCodeTextField(
                  controller: otpController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeColor: Colors.green,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    isButtonEnabled.value = true;
                  },
                  onChanged: (value) {
                    isButtonEnabled.value = value.length == 6;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.green,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled.value
                        ? () async {
                            await verifyOtp();
                          }
                        : null,
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
    );
  }

  Future<void> verifyOtp() async {
    try {
      final response = await NetworkUtils().getMethod(
        Urls.recoveryOtpUrl(email, otpController.text.trim()),
      );

      if (response != null && response['status'] == 'success') {
        SnackBarMessage(Get.context!, "OTP verification done!");
        Get.to(
          () => SetPassword(
            email: email,
            otp: otpController.text,
          ),
        );
      } else {
        SnackBarMessage(
            Get.context!, "OTP verification failed. Check your OTP!", true);
      }
    } catch (e) {
      SnackBarMessage(
          Get.context!, "An error occurred. Please try again.", true);
    }
  }
}
