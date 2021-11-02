import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/profile_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/views/login_view.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  ProfileController passwordController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Change Password'),
      body: Center(
        child: Container(
          height: 350,
          margin: const EdgeInsets.only(left: 24, right: 24),
          child: Card(
            color: AppColors.offWhite,
            elevation: 8,
            shadowColor: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 30, left: 28, right: 28),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        //Password TextField
                        Container(
                          height: 50,
                          //  margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                          child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              //controller: passwordController.enterNewPassword,
                              validator: (value) => value!.isEmpty
                                  ? 'Please input a new password'
                                  : null,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Enter new password',
                                labelText: 'Enter new password',
                                errorStyle:
                                    const TextStyle(color: Colors.orange),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w300,
                                  // light
                                  fontStyle: FontStyle.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.themeColor)),
                              )),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 50,
                          //  margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                          child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: passwordController.enterNewPassword,
                              validator: (value) => value!.isEmpty
                                  ? 'Please input the confirm password'
                                  : null,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Enter confirm password',
                                labelText: 'confirm password',
                                errorStyle:
                                    const TextStyle(color: Colors.orange),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w300,
                                  // light
                                  fontStyle: FontStyle.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.themeColor)),
                              )),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Login button
                  ElevatedButton(
                      style: elevatedButtonStyleThemeColorTow,
                      onPressed: () {
                        Get.offAll(LoginView());
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(color: AppColors.white),
                      )),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
