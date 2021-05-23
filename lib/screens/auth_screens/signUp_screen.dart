import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sample_project/common_widgets/elevated_buttond.dart';
import 'package:sample_project/common_widgets/input_field.dart';
import 'package:sample_project/controllers/auth_controller.dart';
import 'package:sample_project/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  TextEditingController passwordCon = TextEditingController();

  AuthController authController = Get.put(AuthController());
  File pickedImage;
  updateProfileImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  void dispose() {
    nameCon.dispose();
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: authController.isLoading.value,
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Text(
                      'Sign up with email',
                      style: TextStyle(
                        fontSize: 28,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InkWell(
                      onTap: updateProfileImage,
                      child: Container(
                        width: Get.width * 0.4,
                        height: Get.width * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: pickedImage == null
                                ? AssetImage('assets/dummy.jpeg')
                                : FileImage(pickedImage),
                          ),
                        ),
                        child: pickedImage == null
                            ? CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InputField(
                      hint: "Name",
                      controller: nameCon,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
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
                    SizedBox(height: Get.height * 0.06),
                    CommonElevatedButton(
                      buttonText: 'Sign Up',
                      onTapped: onSignupPressed,
                    ),
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSignupPressed() {
    if (pickedImage == null) {
      Get.snackbar('Profile picture is required', '');
      return;
    } else if (nameCon.text.isEmpty ||
        emailCon.text.isEmpty ||
        passwordCon.text.isEmpty) {
      Get.snackbar('No feild can be empty', '');
      return;
    }
    UserModel userModel = UserModel(
      email: emailCon.text.trim(),
      userName: nameCon.text.trim(),
      dateSignedUp: Timestamp.now(),
    );
    authController.signUp(userModel, passwordCon.text.trim(), pickedImage);
    //Get.to(AccountDetailsScreen());
  }
}
