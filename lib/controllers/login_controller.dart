import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/login_api.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var name = 'Login'.obs;
  var isLogin = false.obs;

  final box = GetStorage();

  getLogin() async {
    MyAlertDialog.circularProgressDialog();

    var response = await LoginApi.loginFunc(emailController.text.trim(),
        passwordController.text.trim(), 'fcm', 'did');

    //print('register controller response: ${response.message}');
    if (response != null) {
      if (response.status == 'success') {
        isLogin(true);

        String? userId = response.userid;
        String? mobile = response.phoneno;
        String? firstNameStr = response.fname;
        String? lastNameStr = response.lname;
        String? email = response.email;
        String? profile_image = response.profilepic;
        String? dob = response.dob;

        //String address = response.user!.address;
        // String city = response.user!.city;
        // String state = response.user!.state;
        // String country = response.user!.country;
        // String zip = response.user!.zip;

        print('userid: $userId, mobile: $mobile, name: $name, email: $email');
        box.write('userId', userId);
        box.write('mobile', mobile);
        box.write('name', firstNameStr);
        box.write('lastName', lastNameStr);
        box.write('email', email);
        box.write('profileImage', profile_image);
        box.write('dob', dob);
        name.value = box.read('name').toString();

        Get.back();
        Get.back();
        MySnackbar.successSnackBar('Success', 'Login successfully done');
        // Get.off(PagesView());
      } else if (response.status == 'failure') {
        Get.back();
        MySnackbar.infoSnackBar(
            'Invalid credentials', 'Invalid email or password');
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Login failed', 'Server down, please try again later');
      }
    }
  }
}