import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/apis/regiseter_api.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';

class RegisterController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //print('date is: ${dobController.text}');
  }

  getRegister() async {
    MyAlertDialog.circularProgressDialog();
    //   //email:sam2@gmail.com
    //     // passwd:123456
    //     // FName:Sam2
    //     // LName:Smith
    //     // phno:9876543210
    var response = await RegisterApi.regisetrFunc(
      emailController.text.trim(),
      passwordController.text.trim(),
      firstNameController.text.trim(),
      lastNameController.text.trim(),
      mobileController.text.trim(),
    );

    print('register controller response: ${response.message}');
    if (response != null) {
      if (response.message == 'Successfully Registered.') {
        Get.back();
        Get.back();
        MySnackbar.successSnackBar('Registration Success',
            'Register successfully, Please login to the app');
        //Get.off(() => LoginView());
      } else if (response.message == 'Email Id already Exists') {
        Get.back();
        MySnackbar.infoSnackBar(
            'User already exist', 'Please try with different email and number');
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Registration failed', 'Server down, please try again later');
      }
    }
  }
}
