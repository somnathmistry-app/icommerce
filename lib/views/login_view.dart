import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/login_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/views/forgot_view.dart';
import 'package:icommerce/views/register_view.dart';


class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
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
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  child: Card(
                    elevation: 10,
                    shadowColor: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50, bottom: 50, left: 28, right: 28),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                                  child:

                                  TextFormField(
                                       controller: _loginController.emailController,
                                    validator: (value)=> value!.isEmpty
                                        ? "Please enter email"
                                        : !value.contains('@')
                                        ? "Invalid Email Id"
                                        : null,
                                      decoration: InputDecoration(
                                    hintText: 'Enter email',
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.themeColor,
                                      fontWeight: FontWeight.w600,
                                      // light
                                      fontStyle: FontStyle.normal,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.themeColor)),
                                  )),
                                ),

                                const SizedBox(height: 20),
                                //Password TextField
                                Container(
                                  height: 50,
                                  //  margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                                  child: TextFormField(
                                      controller: _loginController.passwordController,

                                    validator: (value)=> value!.isEmpty ? 'Please input a password': null,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Enter password',
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.themeColor,
                                          fontWeight: FontWeight.w600,
                                          // light
                                          fontStyle: FontStyle.normal,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.themeColor)),
                                      )),
                                ),
                                const SizedBox(height: 20),
                                 InkWell(
                                  onTap: (){
                                    Get.to(const ForgotPassword());
                                  },
                                  child:const Align(
                                    child: Text(
                                      'Forgot password?',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    alignment: Alignment.centerRight,
                                  ),
                                ),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),
                          //Login button
                          Container(
                            height: 45,
                            width: double.infinity,
                            // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                color: AppColors.themeColor,
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.white),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _loginController.getLogin();
                                  }

                                  // Get.offAll(HomePage());

                                  // print('Email: '+.text+" "+'Password: '+_passwordTextController.text);
                                }),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('Do not have any account?',
                                  style: TextStyle(fontSize: 13)),


                              InkWell(
                                onTap: (){
                                    Get.to(RegisterView());
                                },
                                child: Text('Register',
                                    style: TextStyle(fontSize: 15, color: AppColors.themeColorLight, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10)
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
