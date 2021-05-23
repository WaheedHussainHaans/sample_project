import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sample_project/common_widgets/elevated_buttond.dart';
import 'package:sample_project/common_widgets/input_field.dart';
import 'package:sample_project/controllers/auth_controller.dart';
import 'package:sample_project/screens/auth_screens/signUp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: authController.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      Text(
                        'Login with email',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputField(
                        hint: "Email",
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      InputField(
                        hint: "Password",
                        controller: passwordCon,
                        obscure: true,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CommonElevatedButton(
                        buttonText: 'Login',
                        onTapped: onLoginPressed,
                      ),
                      Text(
                        'Don\'t have a account?',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.to(SignUpScreen()),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onLoginPressed() {
    if (emailCon.text.isEmpty || passwordCon.text.isEmpty) {
      Get.snackbar('Feild can\'t be empty', '');
      return;
    }
    authController.login(emailCon.text.trim(), passwordCon.text.trim());
  }
}
