import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:icommerce/apis/forget_password_api.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';

class ForgotPasswordController extends GetxController{
  TextEditingController forgotTEC = TextEditingController();
  forgotPassword() async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    var response = await ForgetPasswordApi.forgetPassOtpSend(forgotTEC.text.trim());

    if (response != null) {
      if (response.status == 'success') {
        Get.back();
        MySnackbar.successSnackBar(
            'OTP sent successfully', 'Please check your mail ${forgotTEC.text.trim()} and enter the otp');
      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }
}