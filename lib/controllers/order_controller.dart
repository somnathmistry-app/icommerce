import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/order_api.dart';
import 'package:icommerce/models/order_list_model.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';
import 'package:icommerce/views/success_view.dart';

class OrderController extends GetxController{
  var box = GetStorage();
  var isLoading = true.obs;
  var orderListProducts = <Orderlist>[].obs;
  TextEditingController commentTec = TextEditingController();
  var rating = 1.0.obs;

  codCartorder(cartid, deliveraddressid) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    var response = await OrderApi.codCartOrder(cartid, deliveraddressid, box.read('userId'));

    if (response != null) {
      if (response.status == 'success') {
        Get.back();
        Get.to(const SuccessView());
      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }

  onlineCartOrder(cartid, deliveraddressid, txnid) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    var response = await OrderApi.onlineCartOrder(cartid, deliveraddressid, box.read('userId'), txnid);

    if (response != null) {
      if (response.status == 'success') {
        Get.back();
        Get.to(const SuccessView());
      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }

  fetchOrderListProducts() async {
    try {
      isLoading(true);
      var products = await OrderApi.fetchOrderList(box.read('userId'));
      print('orderListProduct $products');
      if (products != null) {
        orderListProducts.assignAll(products.orderlist!);
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  addReviewOrder(productid) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    //var response = await OrderApi.addReview(box.read('userId'), commentTec.text.trim(), rating.value.toString(), productid);
    var response = await OrderApi.addReview(box.read('userId'), commentTec.text.trim(), "4", productid);

    if (response.status == 'success') {
      Get.back();
      Get.back();
      MySnackbar.successSnackBar('Thank You', 'Thank you for your valuable review');
    } else {
      Get.back();
      MySnackbar.errorSnackBar('Server down!', 'Please try again later');
    }
  }

  cancelOrder(idd) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    //var response = await OrderApi.addReview(box.read('userId'), commentTec.text.trim(), rating.value.toString(), productid);
    var response = await OrderApi.cancelOrder(box.read('userId'), idd);

    if (response.status == 'success') {
      Get.back();
      Get.back();
      Get.back();
      fetchOrderListProducts();
      MySnackbar.successSnackBar('Cancelled Successfully', 'Your order has cancelled successfully');
    } else {
      Get.back();
      MySnackbar.errorSnackBar('Server down!', 'Please try again later');
    }
  }
  returnOrder(idd) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    //var response = await OrderApi.addReview(box.read('userId'), commentTec.text.trim(), rating.value.toString(), productid);
    var response = await OrderApi.returnOrder(box.read('userId'), idd);

    if (response.status == 'success') {
      Get.back();
      Get.back();
      Get.back();
      fetchOrderListProducts();
      MySnackbar.successSnackBar('Return request send Successfully', 'Your order Return request send successfully');
    } else {
      Get.back();
      MySnackbar.errorSnackBar('Server down!', 'Please try again later');
    }
  }
}