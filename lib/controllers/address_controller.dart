import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/address_api.dart';
import 'package:icommerce/models/address_list_model.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';

class AddressController extends GetxController {
  var box = GetStorage();
  var isLoading = true.obs;
  var addressList = <Addresslist>[].obs;

  TextEditingController nameTec = TextEditingController();
  TextEditingController streetTec = TextEditingController();
  TextEditingController mobileTecOne = TextEditingController();
  TextEditingController mobileTecTwo = TextEditingController();
  TextEditingController landMarkTec = TextEditingController();
  TextEditingController pinTec = TextEditingController();
  TextEditingController cityTec = TextEditingController();
  TextEditingController stateTec = TextEditingController();

  var addressTypeInt = 1.obs;
  var addressType = 'Home'.obs;

  @override
  void onInit() {
    super.onInit();
  } // var addressType = 'Home'.obs;

  //addrs:address
  // addrtype:Home
  // email:email
  // IsActive:true
  // landmark:landmark
  // name:Sam3
  // phno1:9876543213
  // phno2:9876543201
  // pin:1234567
  // userid:9

  fetchAddressList() async {
    try {
      isLoading(true);
      var addresses = await AddressApi.fetchAddressList(box.read('userId'));
      print('addressList $addresses');
      if (addresses != null) {
        addressList.assignAll(addresses.addresslist!);
      }
    } finally {
      isLoading(false);
    }
  }

  addAddress() async {
    MyAlertDialog.circularProgressDialog();
    // var address =
    //     '${streetTec.text.trim()}, ${cityTec.text.trim()}, ${stateTec.text.trim()}';
    var response = await AddressApi.addAddress(
        streetTec.value.text.toString(),
        addressType.value.toString(),
        box.read('email').toString(),
        'true',
        landMarkTec.text.trim().toString(),
        nameTec.text.trim().toString(),
        mobileTecOne.text.trim().toString(),
        mobileTecTwo.text.trim().toString(),
        pinTec.text.trim().toString(),
        cityTec.text.trim().toString(),
        stateTec.text.trim().toString(),
        box.read('userId').toString());

    print('Address status; ${response.status}');

    if (response.status == 'success') {
      Get.back();
      Get.back();
      fetchAddressList();
      //MySnackbar.successSnackBar('Successful', 'Address added successfully');
    } else {
      Get.back();
      MySnackbar.errorSnackBar(
          'Server Down', 'Server down!, Please try again after sometimes');
    }
  }

  editAddress(String addressId) async {
    MyAlertDialog.circularProgressDialog();
    // var address =
    //     '${streetTec.text.trim()}, ${cityTec.text.trim()}, ${stateTec.text.trim()}';
    var response = await AddressApi.editAddress(
        streetTec.value.text.trim().toString(),
        addressType.value.toString(),
        box.read('email').toString(),
        'true',
        landMarkTec.text.trim().toString(),
        nameTec.text.trim().toString(),
        mobileTecOne.text.trim().toString(),
        mobileTecTwo.text.trim().toString(),
        pinTec.text.trim().toString(),
        cityTec.text.trim().toString(),
        stateTec.text.trim().toString(),
        box.read('userId').toString(),
        addressId);

    print('Address status; ${response.status}');

    if (response.status == 'success') {
      Get.back();
      Get.back();
      fetchAddressList();
      //MySnackbar.successSnackBar('Successful', 'Address added successfully');
    } else {
      Get.back();
      MySnackbar.errorSnackBar(
          'Server Down', 'Server down!, Please try again after sometimes');
    }
  }

  deleteAddress(String addressId) async {
    MyAlertDialog.circularProgressDialog();

    var response = await AddressApi.deleteAddress(addressId);

    print('Address status; ${response.status}');

    if (response.status == 'success') {
      Get.back();
      //MySnackbar.successSnackBar('Successfully', 'Address deleted successfully');
    } else {
      Get.back();
      MySnackbar.errorSnackBar(
          'Server Down', 'Server down!, Please try again after sometimes');
    }
  }
}
