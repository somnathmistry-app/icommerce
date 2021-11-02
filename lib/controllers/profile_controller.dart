import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:icommerce/apis/profile_api.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';
import 'package:icommerce/views/pages_view.dart';
import 'dart:io' as Io;

class ProfileController extends GetxController {
 // var image = '';
  var selectedImagePath = ''.obs;
  var base64ProfileImg = ''.obs;
  var selectedDate = 'Select Date'.obs;
  TextEditingController enterNewPassword = TextEditingController();
  var box = GetStorage();

  //update profile
  TextEditingController fnameTec = TextEditingController();
  TextEditingController lnameTec = TextEditingController();
  TextEditingController phoneTec = TextEditingController();
  var isLogin = false.obs;

  //TextEditingController dobController = TextEditingController();

  // void getImage(ImageSource imageSource) async {
  //   final pickedFile = await ImagePicker().getImage(source: imageSource);
  //   if (pickedFile != null) {
  //     selectedImagePath.value = pickedFile.path;
  //     // selectedImageSize.value =
  //     //     ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
  //     //         .toStringAsFixed(2) +
  //     //         'Mb';
  //   } else {
  //     MySnackbar.infoSnackBar(
  //         'No Image selected', 'Please select a image for your profile');
  //   }
  // }

  //readAsBytesSync
  void getImage(ImageSource imageSource) async {
    //final pickedFile = await ImagePicker().getImage(source: imageSource);
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      final bytes = await Io.File(pickedFile.path).readAsBytesSync();
      print('base64image: ${base64EncodeStr(bytes)}');
      //List<int> imageBytes = Io.File(pickedFile.path).readAsBytesSync();
      //print(imageBytes);
      //String base64Image = base64Encode(imageBytes);

      //print("img_base64 : $base64Image");

    } else {
      MySnackbar.infoSnackBar(
          'No Image selected', 'Please select a image for your profile');
    }
  }

   String base64EncodeStr(Uint8List bytes) => base64.encode(bytes);

  changePasswordFunc() async {
    var userId = GetStorage();

    //LoadingComponent.alertDialog('Logging, please wait', '');
    //print('full address.... : ${getLocation()}');

    var response = await ProfileApi.changePasswordApi(
        userId.read('userId'), enterNewPassword.text.trim());

    print('panic api response: ${response.message}');

    if (response.message == 'Successfully changed') {
      Get.back();
      Get.back();
      MySnackbar.successSnackBar(
          'Password changed', 'password change successfully');
    } else {
      Get.back();
      MySnackbar.errorSnackBar(
          'Server down', 'server down please try again later!');
    }
  }

  updateUser() async {
    MyAlertDialog.circularProgressDialog();

    var response = await ProfileApi.userUpdate(
        box.read('userId'),
        fnameTec.text.trim(),
        lnameTec.text.trim(),
        box.read('email'),
        '',
        phoneTec.text.trim(),
        selectedDate.value.toString());

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
        //print('userid: $userId, mobile: $mobile, name: $name, email: $email');

        box.write('userId', userId);
        box.write('mobile', mobile);
        box.write('name', firstNameStr);
        box.write('lastName', lastNameStr);
        box.write('email', email);
        box.write('profileImage', profile_image);
        box.write('dob', dob);
        //name.value = box.read('name').toString();

        Get.back();
        Get.offAll(PagesView());
        MySnackbar.successSnackBar(
            'Success', 'Profile update successfully done');
        // Get.off(PagesView());
      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server down', 'please try again later');
      }
    }
  }
}
