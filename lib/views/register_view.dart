import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/register_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      backgroundColor: AppColors.white,
      body: (Stack(
        children: [
          Positioned(
            left: 0.0,
            child:
                SvgPicture.asset('assets/images/green_back.svg', height: 48.0),
          ),
          Container(
            margin: const EdgeInsets.only(top: 70),
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
                const SizedBox(height: 20),
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
                                  child: TextFormField(
                                      controller:
                                          _registerController.firstNameController,
                                      validator: (value) => value!.isEmpty
                                          ? "Please enter first name"
                                          : null,
                                      decoration: InputDecoration(
                                        hintText: 'Enter First name',
                                        labelText: 'First Name',
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

                                const SizedBox(height: 15),
                                Container(
                                  height: 50,
                                  // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                                  child: TextFormField(
                                      controller:
                                      _registerController.lastNameController,
                                      validator: (value) => value!.isEmpty
                                          ? "Please enter last name"
                                          : null,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Last name',
                                        labelText: 'Last Name',
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

                                const SizedBox(height: 15),
                                //Password TextField
                                Container(
                                  height: 50,
                                  //  margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                                  child: TextFormField(
                                      controller:
                                          _registerController.mobileController,
                                      validator: (value) => value!.isEmpty
                                          ? 'Please enter mobile number'
                                          : value.length < 10
                                              ? 'Please enter 10 digit number'
                                              : null,
                                      decoration: InputDecoration(
                                        hintText: 'Enter mobile',
                                        labelText: 'Mobile',
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

                                const SizedBox(height: 15),
                                Container(
                                  height: 50,
                                  // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                                  child: TextFormField(
                                      controller:
                                          _registerController.emailController,
                                      validator: (value) => value!.isEmpty
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

                                /*
                                InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.maxFinite,
                                    margin: const EdgeInsets.only(
                                        left: 0.0, right: 0.0, top: 15.0),
                                    child: TextFormField(
                                        // validator: (input) => input.length < 1
                                        //     ? "should_be_not_empty"
                                        //     : null,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: AppColors.themeColor),
                                        textAlign: TextAlign.start,
                                        enabled: false,
                                        keyboardType: TextInputType.datetime,
                                        // controller: editProfileController.dobController,
                                        decoration: InputDecoration(
                                          labelText: _registerController
                                                  .dobController.text.isEmpty
                                              ? 'Select DOB'
                                              : _registerController
                                                  .dobController.text,
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
                                ),

                                 */

                                const SizedBox(height: 15),
                                //Password TextField
                                Container(
                                  height: 50,
                                  //  margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                                  child: TextFormField(
                                      controller: _registerController
                                          .passwordController,
                                      validator: (value) => value!.isEmpty
                                          ? 'Please enter password'
                                          : value.length < 4
                                              ? 'Please enter min 4 digit password'
                                              : null,
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                color: AppColors.themeColor,
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.white),
                                ),
                                onPressed: () {
                                  // Get.to(PageView());

                                  if (_formKey.currentState!.validate()) {
                                    _registerController.getRegister();
                                  }
                                }),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('already have an account?',
                                  style: TextStyle(fontSize: 13)),
                              GestureDetector(
                                onTap: () {
                                  Get.off(LoginView());
                                },
                                child: Text('Login',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.themeColorLight,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )

                //Email TextField
              ],
            ),
          )
        ],
      )),
    ));
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate.subtract(const Duration(days: 15 * 365)),
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime(1940, 1, 13),
  //       lastDate: selectedDate.subtract(const Duration(days: 15 * 365)));
  //   if (picked != null) {
  //     setState(() {
  //       selectedDate = picked;
  //       _registerController.dobController.text =
  //           '${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
  //     });
  //   }
  // }
}
