import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/forgot_password_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/views/password_change.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  bool visibilityTag = false;
  ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "otp") {
        visibilityTag = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: (Stack(
        children: [
          Positioned(
            left: 0.0,
            child:
                SvgPicture.asset('assets/images/green_back.svg', height: 48.0),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 80.0,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              Align(
                    alignment: Alignment.center,
                    child: !visibilityTag?const Text(
                        'Enter your registered email id to receive an OTP', style: TextStyle(fontSize: 12, color: Colors.black45)):const Text(
                        'OTP has been sent to your email, Enter OTP to verify',  style: TextStyle(fontSize: 12, color: Colors.black45))),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  child: Card(
                    elevation: 12,
                    shadowColor: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 30, left: 28, right: 28),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                                  child: TextFormField(
                                      controller: forgotPasswordController.forgotTEC,
                                      validator: (value) => value!.isEmpty
                                          ? "Enter OTP"
                                          : !value.contains('@')
                                              ? "Invalid Email Id"
                                              : null,
                                      decoration: InputDecoration(
                                        hintText: 'Enter email',
                                        labelText: 'Enter Registered Email',
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.themeColor,
                                          fontWeight: FontWeight.w400,
                                          // light
                                          fontStyle: FontStyle.normal,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.themeColor)),
                                      )),
                                ),
                                const SizedBox(height: 15),
                                visibilityTag
                                    ? OTPTextField(
                                        margin: const EdgeInsets.only(top: 30),
                                        length: 4,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fieldWidth: 40,
                                        style: const TextStyle(fontSize: 17),
                                        textFieldAlignment:
                                            MainAxisAlignment.spaceAround,
                                        fieldStyle: FieldStyle.underline,
                                        onCompleted: (pin) {
                                         // print("Completed: " + pin);
                                          Get.to(ChangePasswordView());
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          //Login button
                          !visibilityTag
                              ? ElevatedButton(
                                  style: elevatedButtonStyleThemeColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      forgotPasswordController.forgotPassword();
                                      _changed(true, 'otp');
                                    }
                                  },
                                  child: Text(
                                    'Send OTP',
                                    style: TextStyle(color: AppColors.white),
                                  ))
                              : Container(),

                          // ElevatedButton(
                          //         style: elevatedButtonStyleThemeColor,
                          //         onPressed: () {
                          //           Get.to(ChangePasswordView());
                          //         },
                          //         child: Text(
                          //           'Verify',
                          //           style: TextStyle(color: AppColors.white),
                          //         )),

                          const SizedBox(height: 20),
                          visibilityTag
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Not getting otp?',
                                        style: TextStyle(fontSize: 13)),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      onTap: () {},
                                      child: TextButton(
                                        style: textButtonStyleWhite,
                                        onPressed: () {},
                                        child: Text(
                                          'Resend OTP',
                                          style: TextStyle(color: AppColors.themeColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
