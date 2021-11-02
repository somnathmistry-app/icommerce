import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/controllers/order_controller.dart';
import 'package:icommerce/payment/stripe_details.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';

class StripePay {
  final OrderController _orderController = OrderController();
  Map<String, dynamic>? paymentIntentData;

  //cartid, deliveraddressid, txnid
  Future<void> makePayment(
      String amount, String cartid, String deliverAddId) async {
    print('Payment amount in stripe : $amount');
    MyAlertDialog.circularProgressDialog();
    try {
      paymentIntentData = await createPaymentIntent(amount, stripeCurrency);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.light,
        testEnv: true,
        merchantCountryCode: stripeCountryCode,
        merchantDisplayName: merchantDisplayName,
        customerId: paymentIntentData!['id'],
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        //customerEphemeralKeySecret: _paymentSheetData!['ephemeralKey'],
      ));
      Get.back();

      /*
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              merchantCountryCode: 'US',
              merchantDisplayName: 'Somanth'));

       */

      //cartid, deliveraddressid, txnid
      displayPaymentSheet(cartid, deliverAddId, paymentIntentData!['id']);
    } catch (e) {
      print('Exception############: ${e}');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print('calculate amount: ${calculateAmount(amount)}');
      var response =
          await http.post(Uri.parse(stripeUrl), body: body, headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      });
      return jsonDecode(response.body.toString());
    } catch (e) {
      print('Exception.......: ${e}');
    }
  }

  calculateAmount(String amount) {
    final price = double.parse(amount) * 100;
    return price.toInt().toString();
  }

  ////cartid, deliveraddressid, txnid
  displayPaymentSheet(String cartId, String deliverId, String txnId) async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true));
      // setState(() {

      // });
      //  ScaffoldMessenger.of(context)
      //      .showSnackBar(SnackBar(content: Text('Payment Successfull')));
      MySnackbar.successSnackBar('Payment done Successfully',
          'Your stripe payment done successfully done');
      print('cartId: $cartId, delivery: $deliverId, txnId: $txnId');
      if (txnId != null) {
        _orderController.onlineCartOrder(cartId, deliverId, txnId);
      }
      paymentIntentData = null;
    } on StripeException catch (e) {
      print('error@@@@@@@@@@ $e');
      MySnackbar.errorSnackBar('payment failed', 'Please try again later');
    }
  }
}

//MyAlertDialog.circularProgressDialog();
